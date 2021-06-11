import React, { useState } from "react";
import Service from "../service/service.js";
import '../../assets/manage.css';
const GenerateLicense = () => {
  const initialState = {
    username: null,
    email: "",
    licensetype: "",
    startdate: "",
    enddate: " ",
    product:"",
    custlist:""
  };

const licensetype="Trial";
var a=[];
var productString;
  const [info, setInfo] = useState(initialState);
  const [submitted, setSubmitted] = useState(false);
  const [selectedLic,setSelectedLic] = useState(licensetype);

const [fields, setFields] = useState([{value:null}]);

  function handleChange(i, event) {
    const values = [...fields];

    values[i].value = event.target.value;
    setFields(values);
  }

  function handleAdd() {
    const values = [...fields];
    values.push([]);
    setFields(values);
  }

  function handleRemove(i) {
    const values = [...fields];
    values.splice(i, 1);
    setFields(values);
  }
 function handleSelectChange(event) {
        setSelectedLic(event.target.value);
    }

  
  const handleInputChange = event => {

    const { name, value } = event.target;
    setInfo({ ...info, [name]: value });
  };

  const saveInfo = () => {
    for(var j=0;j<fields.length;j++){
       console.log(fields[j].value);
       a.push(fields[j].value);
 productString = a.join(",");

}

    var data = {
      UserName:info.username,
      EmailId:info.email,
      LicenseType:selectedLic,
      StartDate:info.startdate,
      EndDate:info.enddate,
      Product:info.product,
      CustList:productString
    };
    console.log(data);
    

    Service.create(data)
      .then(response => {
        setInfo({
          id: response.data.id,
          UserName:response.data.username,
          EmailId:response.data.email,
          LicenseType:response.data.licensetype,
          StartDate:response.data.startdate,
          EndDate:response.data.enddate,
          Product:response.data.product,
          CustList:productString

        });
        setSubmitted(true);
        console.log(response.data);

      })
      .catch(e => {
        console.log(e);
      });
  };

  const newLicense = () => {
    setInfo(initialState);
    setSubmitted(false);
  };

  return (
    
<div className="submit-form">
      {submitted ? (
        <div>
          <h4>You submitted successfully!</h4>
          <button className="btn btn-success" onClick={newLicense}>
            Add
          </button>
        </div>
      ) : (
        <div>
          <div className="form-group">
            <label htmlFor="username">User Name</label>
            <input
              type="text"
              className="form-control"
              id="username"
              required
              value={info.username || ' '}
              onChange={handleInputChange}
              name="username"
            />
          </div>

          <div className="form-group">
            <label htmlFor="email">Email</label>
            <input
              type="text"
              className="form-control"
              id="email"
              required
              value={info.email || ' '}
              onChange={handleInputChange}
              name="email"
            />
          </div>

          <div className="form-group">
            <label htmlFor="licensetype">License Type</label>
           
             <select value={selectedLic} onChange={handleSelectChange}>
            <option value="Trial">Trial</option>
            <option value="Standard">Standard</option>
            
          </select>
          </div>



          <div className="form-group">
            <label htmlFor="startdate">Start Date</label>
            <input
              type="date"
              className="form-control"
              id="startdate"
              required
              value={info.startdate || ' '}
              onChange={handleInputChange}
              name="startdate"
            />
          </div>

          <div className="form-group">
            <label htmlFor="enddate">End Date</label>
            <input
              type="date"
              className="form-control"
              id="enddate"
              required
              value={info.enddate || ' '}
              onChange={handleInputChange}
              name="enddate"
            />
          </div>

           <div className="form-group">
            <label htmlFor="product">Product</label>
            <input
              type="text"
              className="form-control"
              id="product"
              required
              value={info.product || ' '}
              onChange={handleInputChange}
              name="product"
            />
          </div>

           <div className="form-group">
            <label htmlFor="custlist">Product List</label>
           <br/>
         
 <button type="button" onClick={() => handleAdd()}>
        Add
      </button>
 
      {fields.map((field, idx) => {
        return (
      
          <div key={`${field}-${idx}`}>  <br/>
         <span>
          
            <input
              type="text"
               className="form-con"
                required
                id="custlist"
                name="custlist"
                value={field.value || ' '}
              placeholder="Enter text"
              onChange={e => handleChange(idx, e)}
            />
            <button type="button" onClick={() => handleRemove(idx)}>
              X
            </button></span>
</div>
);
      })}
 </div>

          <button onClick={saveInfo} className="btn btn-success">
            Submit
          </button>
        </div>
      )}
    </div>
  );
    };

export default GenerateLicense;