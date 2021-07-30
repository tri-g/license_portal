import React, {useEffect,useState} from 'react'
import Service from "../service/service.js";
import '../../assets/g-icons.css';
import '../../assets/style.css';
import UserHistory from "../../components/UserHistory";

 

function Manageusers()
{
     const [fetching, setFetching] = useState(false)
  const [data, setData] = useState([])
  function openUser()
  {
     var myWindow = window.open("/users", "myWindow", "width=1000,height=1000");
  }

const fetch_learning_data = () => {
     var results=[];
     Service.getuserdetails()
     .then(res => {
        results=res.data;
         console.log("dsfa",results);    
    setFetching(true)
    setData(results)
    setTimeout(() => {
      setFetching(false)
    }, 1000)
 })
     
  }

  useEffect(() => {
    fetch_learning_data()
  }, [])

return(
    <div className="db-bg">


                <div className="container-fluid">

 <div className="dashboard" style={{height: "auto",maxHeight: "1400px"}}>
              
                    <div className="row row-border">      
                              <div className="col-sm-6 breadcrum"><span style={{position: "relative",left:"50px"}}>
                           <i className="fa fa-home" style={{paddingRight:"10px"}}></i><a href="/dashboard">Home</a>
                           - Manage Users
                        </span></div>
                         <div className="col-4"></div>
                      <div className="col welcome"><h6 >Welcome!</h6>
                          
                          </div>
                    </div>

                 <div className="row break-row" style={{marginBottom: "90px"}}>        
                       <div className="row" style={{margin:"0 auto"}}>
                           <div className="col-md-12 table-responsive">
                               <div className="row" style={{margin: "0 auto", marginBottom: "20px"}}>
                               <span style={{display: "block", width: "50%"}}>
                                <button id="addNewRow" onClick={openUser} className="btn btn-primary btn-sm" style={{width: "40%"}}>Add User</button>
                            </span>
                               </div>
                               <table class="table table-bordered table-striped table-hover table-condensed  text-center" id="DyanmicTable">
                                <thead>
                                    <tr>
                                        <th class="text-center">
                                            ID
                                        </th>
                                        <th class="text-center">
                                            Name
                                        </th>
                                        <th class="text-center">
                                            Email
                                        </th>
                                        <th class="text-center">
                                            Contact No
                                        </th>
                                        <th class="text-center">
                                            Address
                                        </th>
                                        
                                                                   </tr>
                                </thead>

                            {data.map((k, v) => {
                   
                    return <UserHistory key={v.toString()}
                                            last={data.length === v + 1}
                                            id={k.userID}
                                            name={k.userName}
                                            email={k.emailAddress}
                                            num={k.contactNumber} address={k.address}
                                           />
                                            
                  })}
                        </table>            
                            </div>
                       </div>
                  </div>
                        
                        
                        <div className="modal fade" id="edit" tabIndex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
                              <div className="modal-dialog">
                            <div className="modal-content">
                                  <div className="modal-header">
                                <button type="button" className="close" data-dismiss="modal" aria-hidden="true"><span className="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                                <h4 className="modal-title custom_align" id="Heading">Edit Your Detail</h4>
                              </div>
                                  <div className="modal-body">
                                  <div className="form-group">
                                <input className="form-control " type="text" placeholder="Mohsin"/>
                                </div>
                                <div className="form-group">
                                
                                <input className="form-control " type="text" placeholder="Irshad"/>
                                </div>
                                <div className="form-group">
                                <textarea rows="2" className="form-control" placeholder="CB 106/107 Street # 11 Wah Cantt Islamabad Pakistan"></textarea>
                            
                                
                                </div>
                              </div>
                                  <div className="modal-footer ">
                                <button type="button" className="btn btn-warning btn-lg" style={{width: "100%"}}><span className="glyphicon glyphicon-ok-sign"></span> Update</button>
                              </div>
                                </div>
                            
                          </div>
                             
                            </div>
                            
                            
                            
                            <div className="modal fade" id="delete" tabIndex="-1" role="dialog" aria-labelledby="edit" aria-hidden="true">
                              <div className="modal-dialog">
                            <div className="modal-content">
                                  <div className="modal-header">
                                <button type="button" className="close" data-dismiss="modal" aria-hidden="true"><span className="glyphicon glyphicon-remove" aria-hidden="true"></span></button>
                                <h4 className="modal-title custom_align" id="Heading">Delete this entry</h4>
                              </div>
                                  <div className="modal-body">
                               
                               <div className="alert alert-danger"><span className="glyphicon glyphicon-warning-sign"></span> Are you sure you want to delete this Record?</div>
                               
                              </div>
                                <div className="modal-footer ">
                                <button type="button" className="btn btn-success" ><span className="glyphicon glyphicon-ok-sign"></span> Yes</button>
                                <button type="button" className="btn btn-default" data-dismiss="modal"><span className="glyphicon glyphicon-remove"></span> No</button>
                              </div>
                                </div>
                          
                          </div>
                            
                            </div>




                        </div>


                      
                        </div> 
                        




                        </div>
                           
                        

)
};

export default Manageusers;