using System;
using System.Web.Http;
using System.Collections;
using ServCel_Api.Controllers;
using System.Data;
using BPDTSystmAPI.Models;
using System.Text.RegularExpressions;

namespace BPDTSystmAPI.Controllers
{
    public class DA_NLPFrontControllerController : ApiController
    {
        public static Regular_Registration_Data GetNLPAnswerData(Regular_Registration_Data data) {

            try {
                Regular_Registration_Data Rtndata = new Regular_Registration_Data();
                string parameterOne = "";
                string parameterTwo = "";

                if(data.Semester_Id != null) {
                    parameterOne = data.Semester_Id.ToLower();
                }
                if(data.Semester_Name != null)
                {
                    parameterTwo = data.Semester_Name.ToLower();
                }
                ResponseObject response = new ResponseObject();
                NLPCompromise Compromise = new NLPCompromise();

                ArrayList Arlst = new ArrayList();
                string[] test = parameterOne.Split(',');
                int count = test.Length;


                for(int i = 0; i< count; i++) {
                    
                    if(test[i] != null && test[i] != "")
                    { 
                    string[] testInner = test[i].Split(' ');
                    int countInner = testInner.Length;
                        //int index = 0;

                        for(int j = 0; j < countInner; j++)
                        {
                            if(testInner[j].Trim() != null && testInner[j].Trim() != "")
                            {
                                Arlst.Add(testInner[j].Trim());
                            }
                                
                        }
                    }
                }

                response = Compromise.GetParameter(Arlst);
                DA_NLPFrontControllerController cont = new DA_NLPFrontControllerController();

                if(response.ParameterThree == "Test" || response.ParameterThree == "" || response.ParameterThree == null)
                {
                    string str = cont.ProcessNLP(response.ParameterOne,response.ParameterTwo);
                    Rtndata.Semester_Id = str;
                }
                else
                {
                    string str = cont.ProcessNLPForSubject(response.ParameterOne,response.ParameterTwo,response.ParameterFour,response.ParameterThree);
                    Rtndata.Semester_Id = str;
                }

                return Rtndata;
            }
            catch(Exception ex) {
                Regular_Registration_Data Rtndata = new Regular_Registration_Data();
                string str = "Sorry there is no entry regarding this search";
                Rtndata.Semester_Id = str;
                return Rtndata;
                throw ex;
            }
        }

        public string ProcessNLP(string passOne, string passTwo)
        {

            try {
                string query = "select " + passTwo + " as Answer from " + passOne + " where Status = 0";
                ArrayList resultArry = DBConnection.selectRecord(query);
                NLPCompromise Compromise = new NLPCompromise();
                string result = Compromise.SetFrontEndMassage(passTwo) + " of " + Compromise.SetFrontEndMassage(passOne) + " is " + resultArry[0].ToString();
                //result = resultArry.ToString();
                return result;
            }
            catch(Exception ex) {
                throw ex;
            }
        }

        public string ProcessNLPForSubject(string passOne,string passTwo,string passThree, string passFour)
        {
            try
            {
                string query = "select " + passTwo + " as Answer from " + passOne + " Left Join " + passThree;
                ArrayList resultArry = DBConnection.selectRecord(query);
                NLPCompromise Compromise = new NLPCompromise();
                string result = Compromise.SetFrontEndMassage(passTwo) + " of " + Compromise.SetFrontEndMassage(passOne) + " on " + Compromise.SetFrontEndMassage(passFour) + " is " + resultArry[0].ToString();
                //result = resultArry.ToString();
                return result;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

    }
}
