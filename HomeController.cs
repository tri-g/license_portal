using System.Collections.Generic;
using System.Net.Http;
using System.Threading.Tasks;
using Microsoft.AspNetCore.Mvc;
using LicensePortal_APPAPI.Models;
using Newtonsoft.Json;
using LicensePortal_APPAPI.Utilities;
using System;
using System.Collections;
using System.IO;
using Microsoft.AspNetCore.Cors;

namespace LicensePortal_APPAPI.Controllers
{
    [EnableCors]
    //[Route("api/[controller]")]
    [ApiController]
    public class HomeController : ControllerBase
    {
        private object mylist;

        [Route("api/GetUsers")]
        public async Task<IActionResult> GetUsers()
        {
            List<User> objusers = new List<User>();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44319/api/GetUsers"))
                {
                    var apiResponse = await response.Content.ReadAsStringAsync();
                    var decryptedText = TripleDES.Decrypt(apiResponse);
                    objusers = JsonConvert.DeserializeObject<List<User>>(decryptedText);
                   
                }
            }
            return Ok(objusers);
        }
      
        [Route("api/GetUserById/{userid}")]
        public async Task<IActionResult> GetUserById(int userid)
        {
            var EncryptUserid = TripleDES.Encrypt(userid.ToString());
            //var EncryptUserid_esc = Uri.EscapeDataString(EncryptUserid);
            var EncryptUserid_hex = TripleDES.ToHexString(EncryptUserid);
            List<User> objusers = new List<User>();
            using (var httpClient = new HttpClient())
            {
                using (var response = await httpClient.GetAsync("https://localhost:44319/api/GetUserById/"+ EncryptUserid_hex))
                {
                    var apiResponse = await response.Content.ReadAsStringAsync();
                    var decryptedText = TripleDES.Decrypt(apiResponse);
                    objusers = JsonConvert.DeserializeObject<List<User>>(decryptedText);

                }
            }
            return Ok(objusers);
        }
        [EnableCors]
        [HttpPost]
        [Route("api/GenerateLicense")]
        
        public LicenseInfo GenerateLicense([FromBody] LicenseInfo licensedetails)
        {
            var dict = new Dictionary<string, string>();
            var myList = licensedetails.CustList as IEnumerable;
            if (mylist != null)
            {
                foreach (var element in myList)
                {
                    dict.Add(element.ToString(), "Yes");
                }
            }
            


        string UserName = licensedetails.UserName;
            string EmailId = licensedetails.EmailId;
            var passPhrase = licensedetails.EmailId;
            var keyGenerator = Portable.Licensing.Security.Cryptography.KeyGenerator.Create();
            var keyPair = keyGenerator.GenerateKeyPair();
            var privateKey = keyPair.ToEncryptedPrivateKeyString(passPhrase);
            var publicKey = keyPair.ToPublicKeyString();

            var license = Portable.Licensing.License.New()
            .WithUniqueIdentifier(Guid.NewGuid())
            .As(licensedetails.LicenseType == "1" ? Portable.Licensing.LicenseType.Trial : Portable.Licensing.LicenseType.Standard)
            .ExpiresAt(Convert.ToDateTime(licensedetails.EndDate))
            .WithMaximumUtilization(5)
            .WithProductFeatures(dict)
            .LicensedTo(UserName, EmailId)
            .CreateAndSignWithPrivateKey(privateKey, passPhrase);

            ////License file stored 
            // var folderName = Path.Combine("LicenseFiles");
            // var pathToSave = Path.Combine(Directory.GetCurrentDirectory(), folderName);
            //System.IO.File.WriteAllText(pathToSave, license.ToString());
            //var fullPath = Path.Combine(pathToSave, pathToSave);
            var path = Path.Combine("LicenseFiles/" + licensedetails.UserName + "_" + licensedetails.Product + "_License.lic");
            System.IO.File.WriteAllText(path, license.ToString());
            var keypath = Path.Combine("LicenseFiles/" + licensedetails.UserName + "_" + licensedetails.Product + "_Key.txt");
            System.IO.File.WriteAllText(keypath, publicKey.ToString());
            //return Ok("Success");
            return licensedetails;
        }
    }
}
