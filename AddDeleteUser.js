import React, {useEffect,useState,useMemo} from 'react'
import Service from "../service/service.js";
import UserHistory from "../../components/UserHistory";
import '../../assets/g-icons.css';
import '../../assets/style.css';
import '../../assets/table1.css';
import { Modal} from "react-bootstrap";
import { useHistory } from "react-router-dom";
import $ from 'jquery';
import Validate from '../../components/UserValidation';

function Manageusers()
{
  const history = useHistory();
  const initialState = 
  {
        userID: "",
        userName: "",
        emailAddress: "",
        contactNumber: 0,
        address: "",
        lastlogin:"",
        password:"",
        orgname:""
  };
  const initialStateorg = 
  {
    OrgUserID:"",
        OrgID: "",
        OrgName: "",
        
        
  };
 
  const [errors, setErrors] = useState({});
  const [isSubmitting, setIsSubmitting] = useState(false);
  const handleShow1 = () => setShow1(true);
  const [show1, setShow1] = useState(false);

  const handleClose1 = () => {setShow1(false); setShow(false);}
  const [value, setValue] = useState(1);

  const [showModal, setShow] = useState(false);
  const handleClose = () => setShow(false);
  const handleShow = () =>{setShow(true);setShow1(true);}
  const [fetching, setFetching] = useState(false)
  const [data, setData] = useState([initialState]);
  const [org, setOrg] = useState([]);

  const [submitted, setSubmitted] = useState(false);
  const [info, setInfo] = useState(initialState);


  const fetch_learning_data = () =>
  {
    var results=[];
    Service.getuserdetails()
    .then(res => {
      results=res.data;
      setFetching(true);
      setData(results);

      setTimeout(() => {
        setFetching(false)
      }, 1000)
      
    })  
    setFetching(true);
    var results1=[];
    Service.getorganizationdetails()
    .then(res => {
      results1=res.data;
      setFetching(true);
      setOrg(results1);
      console.log(results1);
      setTimeout(() => {
        setFetching(false)
      }, 1000)
    })
    
  }

  var name=Service.readMessage();
console.log()
  useEffect(() => {
    fetch_learning_data();
    if (Object.keys(errors).length === 0 && isSubmitting) {
      console.log("1s");   
      saveInfo();
   }
  }, [errors])
  const handleSubmit = (event) => {
    if (event) event.preventDefault();
    setErrors(Validate(info));
    setIsSubmitting(true);
    console.log("im here");
    
  };
  const handleInputChange = event => {
    const { name, value } = event.target;
    setInfo({ ...info, [name]: value });
  };
  const handleInputChange1 = event => {
    const { name, value } = event.target;
    setOrg({ ...org, [name]: value });
  };
  function success(){
    window.location.reload();
  }
  const saveInfo = () => {
    var data = {
     userID:+info.userID,
        userName: info.userName,
        orgID:+value,
        emailAddress: info.emailAddress,
        contactNumber: +info.contactNumber,
        address:info.address,
        lastlogin: "2020-08-25T18:30:00",
        password: info.password,
       
    };
    console.log(data);
    Service.adduser(data)
      .then(response => {
        setInfo({
            userName: response.data.userName,
            emailAddress: response.data.emailAddress,
            contactNumber: response.data.contactNumber,
            address:response.data.address,
            lastlogin: "2020-08-25T18:30:00",
             password: response.data.password,
        


        });

        setSubmitted(true);
        console.log(response.data);
      })
      .catch(e => {
        console.log(e);
      });
  };



const [offset, setOffset] = useState(0); 
const itemsPerPage = 5;
const changePage = offset => {
  setOffset(offset); 
};
let listItems = [];
  for (
    let i = offset * itemsPerPage;
    i < offset * itemsPerPage + itemsPerPage;
    i++
  ) {
    if (i >= data.length) {
      break;
    }
    listItems.push(data[i]);
  }
  listItems = listItems.map((k, v) => {
    return (
      <tbody>               
     
                 <UserHistory key={v.toString()}
                                         last={data.length === v + 1}
                                         id={k.userID}
                                         name={k.userName}
                                         email={k.emailAddress}
                                         num={k.contactNumber} address={k.address}
                                         orgname={k.orgName}                                     
                                         initialState={initialState}
                                         org={org} 
                                         val={value}
                                         password={k.password}
                                         
                                        />
                                         
             
                     </tbody> 
    );
  });

  const btns = [];
  for (let i = 1; i <= Math.ceil(data.length / itemsPerPage); i++) {
    const elem = (
      <span className="pagination-btn" onClick={() => changePage(i - 1)}>
        {i}
      </span>
    );
    btns.push(elem);
  }



  return(
  <div className="db-bg">
    <div className="container-fluid">
      <div className="dashboard" style={{height: "auto", maxHeight: "1400px"}}>
        <div className="row row-border">
          <div className="col-sm-6 breadcrum"><span style={{position: "relative",left:"50px"}}>
            <i className="fa fa-home" style={{paddingRight: "10px"}}></i><a href="/dashboard">Home</a>- Manage - Add User
            </span></div>
            <div className="col-4"></div>
            <div className="col welcome"><h6 >Welcome {name}!</h6>
            </div>
            </div>
                 <div className="row break-row" style={{marginBottom: "90px"}}>  
                    <div className="container">
                    <div className="row" style={{marginBottom: "20px"}}>
                               <span style={{display: "block", width: "50%"}}>
                                <button id="addNewRow" className="btn btn-sm" aria-hidden="true" data-toggle="modal" data-target="#myModal" onClick={handleShow} style={{width: "40%"}}>Add User</button>
                            </span>
                               </div>
                        <div className="row">                         
                        <table className="table table-bordered table-striped table-hover table-condensed table-fixed text-center" id="DyanmicTable">
                                 <thead>
                                    <tr>
                                        <th className="text-center">Name</th>                                       
                                        <th className="text-center">Email</th>                                 
                                        <th className="text-center">Contact No</th>
                                        <th className="text-center">Address </th>  
                                        <th className="text-center">Organization</th>  

                                        <th></th>
                                    </tr>                                                                    
                                </thead>                              
   
                       {listItems}
                       </table> 
                       {btns}
                                
                            </div>



                           
                       </div>
                  </div>
                         
               
      <Modal id="center" show={showModal} onHide={handleClose}>      
      <div className="modal-dialog" style={{width: "100%",margin:"0px",padding:"0px"}}>
      <div className="modal-content">
      <div className="modal-header">
            <h5><strong>Add User</strong></h5>
           <button type="button" className="close"  onClick={handleClose} data-dismiss="modal">&times;</button>
        </div>
        <div className="modal-body">
        {submitted ? (
        <div>
          <Modal id="center" show={show1} onHide={handleClose1}>
          <div className="modal-body">
          <h2>    User Added Successfully!</h2>
       
          <input type="reset" className="btn btn-secondary" style={{width:"10%",float:"right",height:"3%"}} onClick={success} value="OK"/>
             
        </div>
      </Modal>
    </div>
      ) : (
            <form className="form" role="form" autoComplete="off" noValidate>

                                              
 <div className="form-group row">
            <label className="col-lg-5 col-form-label form-control-label" htmlFor="licensetype">Organization</label>
           <div className="col-lg-7">
             <select className="form-control selectpicker" id="select-country" data-live-search="true" name="org" value={value}
      onChange={(e) => setValue(e.currentTarget.value)}>
            
             {org.map((item,value) => (
        <option
          key={value}
          value={item.orgID}
        >
         {item.orgName}
        </option>
      ))}
          </select>
          
          </div></div>
         
             
                <div className="form-group row">
                
                    <label className="col-lg-5 col-form-label form-control-label">Name</label>

                    <div className="col-lg-7">
                   
                        <input className="form-control" type="text" id="userName" name="userName" onChange={handleInputChange} value={info.userName || ''} isrequired={true}  placeholder="User Name"/>
                        {errors.userName && (
                    <p style={{color:"red",fontSize:".7em"}}>{errors.userName}</p>
                  )}
                    </div>
                </div>
                <div className="form-group row">
                    <label className="col-lg-5 col-form-label form-control-label">Email</label>
                    <div className="col-lg-7">
                        <input className="form-control" type="email" id="emailAddress" name="emailAddress" onChange={handleInputChange} value={info.emailAddress || ''} required placeholder="Email Address"/>
                        {errors.emailAddress && (
                    <p style={{color:"red",fontSize:".7em"}}>{errors.emailAddress}</p>
                  )}
                    </div>
                </div>

                <div className="form-group row">
                    <label className="col-lg-5 col-form-label form-control-label">Contact No</label>
                    <div className="col-lg-7">
                        <input className="form-control" type="text" id="contactNumber" name="contactNumber" onChange={handleInputChange} value={info.contactNumber || ''} required placeholder="Contact Number"/>
                        {errors.contactNumber && (
                    <p style={{color:"red",fontSize:".7em"}}>{errors.contactNumber}</p>
                  )}
                    </div>
                </div>

               <div className="form-group row">
                    <label className="col-lg-5 col-form-label form-control-label">Address</label>
                    <div className="col-lg-7">
                        <input className="form-control" type="text" id="address" name="address" onChange={handleInputChange} value={info.address || ''} required placeholder="Address"/>
                        {errors.address && (
                    <p style={{color:"red",fontSize:".7em"}}>{errors.address}</p>
                  )}
                    </div>
                </div>

                <div className="form-group row">
                    <label className="col-lg-5 col-form-label form-control-label">Password</label>
                    <div className="col-lg-7">
                        <input className="form-control" type="password" id="password" name="password" onChange={handleInputChange} value={info.password || ''} required placeholder="Password"/>
                        {errors.password && (
                    <p style={{color:"red",fontSize:".7em"}}>{errors.password}</p>
                  )}
                    </div>
                </div>

            <div className="row" style={{padding:"10px"}}></div>
                <div className="form-group row">
                    <label className="col-lg-6 col-form-label form-control-label"></label>
                    <div className="col-lg-3">
                        <input type="reset" className="btn btn-secondary"  onClick={handleClose} value="Cancel"/>
                        </div>
                        <div className="col-lg-3">
                            <input type="button" className="btn btn-primary" value="Add" onClick={handleSubmit} data-toggle="modal" data-target="#myModal"/>
                        </div>
                    </div>
                </form>
                )}

            </div>






        </div></div>
                                    </Modal>                   
                      
                        
     


    

 </div>
</div>
</div>

)
};

export default Manageusers;