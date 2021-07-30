import http from "./http-common";

//const [mess, setMess] = useState();
var message='';
var message1='';
const create = data => {
  return http.post("/GenerateLicense", data);
};
const login_validation = data => {
  return http.post("/token", data);
};
  function getuserdetails() {
  return http.get('/user/GetUsers');
  }
 function setMessage(message){
     localStorage.setItem('message', JSON.stringify(message));
   }
     console.log(message);
   function readMessage(){
   	console.log("from read", message)
   var retrievedObject =localStorage.getItem('message');
   message1=JSON.parse(retrievedObject);
       return message1;
   }
export default {
 
  create,
  login_validation,
  setMessage,
  readMessage,
  getuserdetails
};