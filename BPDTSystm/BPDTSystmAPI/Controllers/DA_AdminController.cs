using System;
using System.Web.Http;
using System.Collections;
using ServCel_Api.Controllers;
using System.Collections.Generic;
using System.Data;
using System.Linq;


namespace BPDTSystmAPI.Controllers
{
    public class DA_AdminController : ApiController
    {
        //Here we have used autocomplete functions for all prorata,regulara and repeat
        //START
        public static ArrayList AutocompleteProrataRegistrationData(Pro_Rata_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Pro_Rata_Registration_Data] '" + data.Semester_Id + "',1";

                DataTable result = DBConnection.selectRecords(query);
                if(result != null)
                {
                    foreach(DataRow dtRow in result.Rows)
                    {
                        Pro_Rata_Registration_Data rtn = new Pro_Rata_Registration_Data();
                        rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                        arr.Add(rtn);
                    }
                }
                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList AutocompleteRegularRegistrationData(Pro_Rata_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Regular_Registration_Data] '" + data.Semester_Id + "',1";

                DataTable result = DBConnection.selectRecords(query);
                if(result != null)
                {
                    foreach(DataRow dtRow in result.Rows)
                    {
                        Pro_Rata_Registration_Data rtn = new Pro_Rata_Registration_Data();
                        rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                        arr.Add(rtn);
                    }
                }
                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList AutocompleteRepeatRegistrationData(Pro_Rata_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Repeat_Registration_Data] '" + data.Semester_Id + "',1";

                DataTable result = DBConnection.selectRecords(query);
                if(result != null)
                {
                    foreach(DataRow dtRow in result.Rows)
                    {
                        Pro_Rata_Registration_Data rtn = new Pro_Rata_Registration_Data();
                        rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                        arr.Add(rtn);
                    }
                }
                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList LoadProrataRegistrationData(Pro_Rata_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Pro_Rata_Registration_Data] '" + data.Semester_Id + "',2";

                DataTable result = DBConnection.selectRecords(query);

                foreach(DataRow dtRow in result.Rows)
                {
                    Pro_Rata_Registration_Data rtn = new Pro_Rata_Registration_Data();
                    rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                    rtn.Pro_Rata_Registration_Start_Date = dtRow["Pro_Rata_Registration_Start_Date"].ToString();
                    rtn.Pro_Rata_Registration_End_Date = dtRow["Pro_Rata_Registration_End_Date"].ToString();
                    rtn.Pro_Rata_Fee = dtRow["Pro_Rata_Fee"].ToString();
                    rtn.Last_Payment_Date_From = dtRow["Last_Payment_Date_From"].ToString();
                    rtn.Last_Payment_Date_To = dtRow["Last_Payment_Date_To"].ToString();
                    rtn.Late_Payment_Fee = dtRow["Late_Payment_Fee"].ToString();
                    rtn.Date_Time = dtRow["Allow_Subject_Name"].ToString(); // this is used to pass the subject list to the front end
                    arr.Add(rtn);
                }

                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList LoadRegularRegistrationData(Regular_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Regular_Registration_Data] '" + data.Semester_Id + "',2";

                DataTable result = DBConnection.selectRecords(query);

                foreach(DataRow dtRow in result.Rows)
                {
                    Regular_Registration_Data rtn = new Regular_Registration_Data();
                    rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                    rtn.Semester_Name = dtRow["Semester_Name"].ToString();
                    rtn.Payment_Start_Date = dtRow["Payment_Start_Date"].ToString();
                    rtn.Payment_End_Date = dtRow["Payment_End_Date"].ToString();
                    rtn.Semester_Start_Date = dtRow["Semester_Start_Date"].ToString();
                    rtn.Semester_End_Date = dtRow["Semester_End_Date"].ToString();
                    rtn.Semester_Fee = dtRow["Semester_Fee"].ToString();
                    rtn.Late_Payment_Date_From = dtRow["Late_Payment_Date_From"].ToString(); // this is used to pass the subject list to the front end
                    rtn.Late_Payment_Date_To = dtRow["Late_Payment_Date_To"].ToString();
                    rtn.Late_Payment_Fee = dtRow["Late_Payment_Fee"].ToString();
                    arr.Add(rtn);
                }

                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList LoadRepeatRegistrationData(Repeat_Registration_Data data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC [dbo].[Autocomplete_Repeat_Registration_Data] '" + data.Semester_Id + "',2";

                DataTable result = DBConnection.selectRecords(query);

                foreach(DataRow dtRow in result.Rows)
                {
                    Repeat_Registration_Data rtn = new Repeat_Registration_Data();
                    rtn.Semester_Id = dtRow["Semester_Id"].ToString();
                    rtn.Repeat_Registration_Start_Date = dtRow["Repeat_Registration_Start_Date"].ToString();
                    rtn.Repeat_Registration_End_Date = dtRow["Repeat_Registration_End_Date"].ToString();
                    rtn.Repeat_Fee = dtRow["Repeat_Fee"].ToString();
                    rtn.Date_Time = dtRow["Allow_Subject_Name"].ToString(); // this is used to pass the subject list to the front end
                    arr.Add(rtn);
                }

                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
        //END
        public static ArrayList LoginAuthorization (Users_List data) {

            Users_List rtn = new Users_List();
            //string rtn;
            ArrayList arr = new ArrayList();
            string query;
           
            try {

                query = "exec [dbo].[Login_Data] '"
                    + data.Email + "','"
                    + data.Temp_Password + "','"
                    + data.Status + "'";

                DataTable result = DBConnection.selectRecords(query);

                foreach(DataRow dtRow in result.Rows)
                {
                    rtn.Index_No = dtRow["RESULT"].ToString();
                    //rtn.Index_No = dtRow["RESULT"].ToString();
                }
                //arr = DBConnection.selectRecord(query);
                arr.Add(rtn);
                return arr;
            }
            catch(Exception ex) {
                throw ex;
            }
        }

        //here we create static methods api controllers to save data

        public static String SaveRegularRegistrationData(Regular_Registration_Data data)
        {
            string str = "";
            string query;
            ArrayList arr = new ArrayList();

            try
            {
                query = "exec [dbo].[Save_Regular_Registration_Data] '"
                    + data.Semester_Id+"','"
                    + data.Semester_Name + "','"
                    + data.Payment_Start_Date + "','"
                    + data.Payment_End_Date + "','"
                    + data.Semester_Start_Date + "','"
                    + data.Semester_End_Date + "','"
                    + data.Semester_Fee + "','"
                    + data.Late_Payment_Date_From + "','"
                    + data.Late_Payment_Date_To + "','"
                    + data.Late_Payment_Fee + "','"
                    + data.Status + "'";

                arr = DBConnection.selectRecord(query);
                

                if(arr.Count >0)
                {
                    str = "Success";
                   
                    return str;
                }
                else {
                    str = "Error occur";
                   
                    return str;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }

            
        }

        public static String SaveProRataRegistrationData(Pro_Rata_Registration_Data data)
        {
            string str = "";
            string query;
            string UUID = Guid.NewGuid().ToString();
            ArrayList arr = new ArrayList();

            try
            {
                DataTable MappingTable = new DataTable();

                MappingTable.Columns.Add("Ref_No");
                MappingTable.Columns.Add("Allow_Subject_Name");

                List<Pro_Rata_Registration_Subject_List> MDetails = new List<Pro_Rata_Registration_Subject_List>();
                MDetails = data.Pro_Rata_Registration_Subject_List.ToList<Pro_Rata_Registration_Subject_List>();

                foreach(Pro_Rata_Registration_Subject_List item in MDetails)
                {
                    DataRow itemRow = MappingTable.NewRow();

                    itemRow["Ref_No"] = UUID.ToString();
                    itemRow["Allow_Subject_Name"] = item.Allow_Subject_Name.ToString();

                    MappingTable.Rows.Add(itemRow);
                }

                query = "exec [dbo].[Save_Pro_Rata_Registration_Data] '"
                    + UUID + "','"
                    + data.Semester_Id + "','"
                    + data.Pro_Rata_Registration_Start_Date + "','"
                    + data.Pro_Rata_Registration_End_Date + "','"
                    + data.Pro_Rata_Fee + "','"
                    + data.Last_Payment_Date_From + "','"
                    + data.Last_Payment_Date_To + "','"
                    + data.Late_Payment_Fee + "','"
                    + data.Status + "'";

                DBConnection.PerformBulkCopy(MappingTable,"[dbo].Temp_Pro_Rata_Registration_Subject_List");

                arr = DBConnection.selectRecord(query);
               
                if(arr.Count > 0)
                {
                    str = "Success";
                   
                    return str;
                }
                else
                {
                    str = "Error occur";
                   
                    return str;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static String SaveRepeatRegistrationData(Repeat_Registration_Data data)
        {
            string str = "";
            string query;
            string UUID = Guid.NewGuid().ToString();
            ArrayList arr = new ArrayList();

            try
            {
                DataTable MappingTable = new DataTable();

                MappingTable.Columns.Add("Ref_No");
                MappingTable.Columns.Add("Allow_Subject_Name");

                List<Repeat_Registration_Subject_List> MDetails = new List<Repeat_Registration_Subject_List>();
                MDetails = data.Repeat_Registration_Subject_List.ToList<Repeat_Registration_Subject_List>();

                foreach(Repeat_Registration_Subject_List item in MDetails)
                {
                    DataRow itemRow = MappingTable.NewRow();

                    itemRow["Ref_No"] = UUID.ToString();
                    itemRow["Allow_Subject_Name"] = item.Allow_Subject_Name.ToString();

                    MappingTable.Rows.Add(itemRow);
                }

                query = "exec [dbo].[Save_Repeat_Registration_Data] '"
                    + UUID + "','"
                    + data.Semester_Id + "','"
                    + data.Repeat_Registration_Start_Date + "','"
                    + data.Repeat_Registration_End_Date + "','"
                    + data.Repeat_Fee + "','"
                    + data.Status + "'";

                DBConnection.PerformBulkCopy(MappingTable,"[dbo].Temp_Repeat_Registration_Subject_List");

                arr = DBConnection.selectRecord(query);
              
                if(arr.Count > 0)
                {
                    str = "Success";
                    
                    return str;
                }
                else
                {
                    str = "Error occur";
                    
                    return str;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        //This is used to load all users data to the system

        public static ArrayList GetAllUserData(Users_List data)
        {   
            ArrayList arr = new ArrayList();
            string query;

            try
            {

                query = "EXEC[dbo].[Get_All_Users] '','','','','','',1";

                DataTable result = DBConnection.selectRecords(query);

                foreach(DataRow dtRow in result.Rows)
                {
                    Users_List rtn = new Users_List();
                    rtn.Index_No = dtRow["Index_No"].ToString();
                    rtn.Student_Name = dtRow["Student_Name"].ToString();
                    rtn.Student_Type = dtRow["Student_Type"].ToString();
                    rtn.Course = dtRow["Course"].ToString();
                    rtn.Email = dtRow["Email"].ToString();
                    arr.Add(rtn);
                }
               
                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static ArrayList SaveUserData(Users_List data)
        {
            ArrayList arr = new ArrayList();
            string query;

            try
            {
                query = "EXEC[dbo].[Get_All_Users] '"+
                     data.Index_No + "','"+
                     data.Student_Name + "','"+
                     data.Temp_Password + "','"+
                     data.Student_Type + "','"+
                     data.Course + "','"+
                     data.Email + "','"+
                      data.Status + "'";

                ArrayList result = DBConnection.selectRecord(query);

                return arr;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public static String DeleteAllData(Regular_Registration_Data data)
        {
            string str = "";
            string query;
            ArrayList arr = new ArrayList();

            try
            {
                query = "exec [dbo].[DELETE_ALL_DATA] '',1";
                    
                arr = DBConnection.selectRecord(query);


                if(arr.Count > 0)
                {
                    str = "Success";

                    return str;
                }
                else
                {
                    str = "Error occur";

                    return str;
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }


        }
    }
}
