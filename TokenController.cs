using LicensePortal_APPAPI.Models;
using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.IdentityModel.Tokens;
using System;
using System.IdentityModel.Tokens.Jwt;
using System.Security.Claims;
using System.Text;
using System.Threading.Tasks;
using System.Linq;
using Microsoft.AspNetCore.Cors;
using System.Collections.Generic;

namespace LicensePortal_APPAPI.Controllers
{
    [EnableCors]
    [Route("api/[controller]")]
    [ApiController]
    public class TokenController : ControllerBase
    {
        public IConfiguration _configuration;
        private DatabaseContext _context;

        //login authentication
        public TokenController(IConfiguration config, DatabaseContext context)
        {
            _configuration = config;
            _context = context;
        }
        [EnableCors]
        [HttpPost]
        public async Task<IActionResult> Post(User _userData)
        {

            if (_userData != null && _userData.EmailAddress != null && _userData.password != null)
            {
                var user = await GetUser(_userData.EmailAddress, _userData.password);

                if (user != null)
                {
                    User u = GetById(_userData.EmailAddress);
                    var claims = new[] {
                    new Claim(JwtRegisteredClaimNames.Sub, _configuration["Jwt:Subject"]),
                    new Claim(JwtRegisteredClaimNames.Jti, Guid.NewGuid().ToString()),
                    new Claim(JwtRegisteredClaimNames.Iat, DateTime.UtcNow.ToString()),

                   };

                    var key = new SymmetricSecurityKey(Encoding.UTF8.GetBytes(_configuration["Jwt:Key"]));

                    var signIn = new SigningCredentials(key, SecurityAlgorithms.HmacSha256);

                    var token = new JwtSecurityToken(_configuration["Jwt:Issuer"], _configuration["Jwt:Audience"], claims, expires: DateTime.UtcNow.AddDays(1), signingCredentials: signIn);

                    return Ok(u.UserName);
                }
                else
                {
                    return BadRequest("Invalid credentials");
                }
            }
            else
            {
                return BadRequest();
            }
        }

        private async Task<User> GetUser(string email, string password)
        {
            return await _context.Users.FirstOrDefaultAsync(u => u.EmailAddress == email && u.password == password);
        }

        public User GetById(string email)
        {
            return _context.Users.Where(x => x.EmailAddress == email).FirstOrDefault();
        }

        //get user details
        [HttpGet]
        [Route("GetUsers")]
        public IEnumerable<User> Get()
        {
            var result = _context.Users.ToList();
            return result;
        }

        //add user
        [HttpPost]
        [Route("AddUser")]
        public async Task<IActionResult> POST(User _userData)
        {
            User us = new User();
            us.UserName = _userData.UserName;
            us.Address = _userData.Address;
            us.ContactNumber = _userData.ContactNumber;
            us.EmailAddress = _userData.EmailAddress;
            us.lastlogin = _userData.lastlogin;
            us.password = _userData.password;
            _context.Users.Add(us);
            _context.SaveChanges();
            return Ok(us);
        }

        //get organization details
        [HttpGet]
        [Route("GetOrganization")]
        public IEnumerable<Organization> Getdata()
        {
            var result = _context.Organization.ToList();
            return result;
        }

        //add organization
        [HttpPost]
        [Route("AddOrganization")]
        public async Task<IActionResult> POSTorg(Organization _orgData)
        {
            Organization or = new Organization();
            or.OrgId = _orgData.OrgId;
            or.OrgName = _orgData.OrgName;
            or.OrgEmailAdd = _orgData.OrgEmailAdd;
            or.OrgAddress = _orgData.OrgAddress;
            or.PostCode = _orgData.PostCode;
            or.OrgType = _orgData.OrgType;
            or.OrgConNumber = _orgData.OrgConNumber;
            or.OrgContactName = _orgData.OrgContactName;
            or.OrgNumber = _orgData.OrgNumber;
            _context.Organization.Add(or);
            _context.SaveChanges();
            return Ok(or);
        }

        //get roles
        [HttpGet]
        [Route("RoleType")]
        public IEnumerable<Roles> Getrole()
        {
            var result = _context.Roles.ToList();
            return result;
        }

        //update user
        [HttpPut("Update/{id}")]
        public async Task<IActionResult> Edit(int id, User _userData)
        {
            if (id != _userData.UserID)
            {
                return BadRequest();
            }

            _context.Entry(_userData).State = EntityState.Modified;

            try
            {
                await _context.SaveChangesAsync();

            }
            catch (DbUpdateConcurrencyException)
            {
                if (!UserExists(id))
                {
                    return NotFound();
                }
                else
                {
                    throw;
                }
            }
            return NoContent();
        }

        //delete user
        [HttpDelete("DeleteUser/{id}")]
        public async Task<ActionResult<User>> DeleteUser(int id)
        {
            var users = await _context.Users.FindAsync(id);
            if (users == null)
            {
                return NotFound();
            }
            _context.Users.Remove(users);
            await _context.SaveChangesAsync();
            return NoContent();
        }

        private bool UserExists(int id)
        {
            throw new NotImplementedException();
        }
    }
}