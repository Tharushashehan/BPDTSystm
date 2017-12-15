using System;
using System.Collections;
using System.Diagnostics;
using System.Linq;
using System.Text.RegularExpressions;

namespace BPDTSystmAPI.Models
{
    public class NLPCompromise
    {
        public ResponseObject GetParameter(ArrayList Arrlstfound) {

            ArrayList Arlst = new ArrayList();
            Arlst = Arrlstfound;
            ResponseObject response = new ResponseObject();
            int[] TableCountOccurences = Enumerable.Repeat(100 , Arlst.Count).ToArray(); // new int[Arlst.Count];
            int[] ColumnCountOccurences = Enumerable.Repeat(100,Arlst.Count).ToArray();
            int[] SubjectCountOccurences = Enumerable.Repeat(100,Arlst.Count).ToArray();
            int m = 0;

            for(int i = 0; i < Arlst.Count; i++)
            {
                if(CheckSubject((string)Arlst[i]) != 100)
                {
                    SubjectCountOccurences[m] = CheckSubject((string)Arlst[i]);
                    m++;
                }
            }

            SubjectCountOccurences = SubjectCountOccurences.Except(new int[] { 100 }).ToArray();

            if(SubjectCountOccurences.Length > 0)
            {
                int maxRepeatedSubject = (from item in SubjectCountOccurences
                                          group item by item into g
                                        orderby g.Count() descending
                                        select g.Key).First();
                if(maxRepeatedSubject != 100)
                {
                    string[] StringArraySubject = new string[10];
                    StringArraySubject = this.SubjectSet();
                    response.ParameterThree = StringArraySubject[maxRepeatedSubject];
                }
                
                response.ParameterOne = this.GetParameterOfLast(Arlst).ParameterOne;
                response.ParameterTwo = this.GetParameterOfLast(Arlst).ParameterTwo;

                if(response.ParameterOne == "pro_rata_registration_data")
                {
                    response.ParameterFour = " [Pro_Rata_Registration_Subject_List] on [Pro_Rata_Registration_Data].[NewIdSet] = [Pro_Rata_Registration_Subject_List].[Pro_Rata_Registration_Id] where[Allow_Subject_Name] = '" + response.ParameterThree + "' and[Pro_Rata_Registration_Data].Status = 0";
                }
                else
                {
                    response.ParameterFour = " [Repeat_Registration_Subject_List] on [Repeat_Registration_Id] = [NewIdSet] where [Allow_Subject_Name] = '" + response.ParameterThree + "' and [Repeat_Registration_Data].Status = 0";
                }
            }

            else
            {
                response.ParameterThree = "Test";
                response.ParameterOne = this.GetParameterOfLast(Arlst).ParameterOne;
                response.ParameterTwo = this.GetParameterOfLast(Arlst).ParameterTwo;
            }

            return response;
        }

        public ResponseObject GetParameterOfLast(ArrayList Arrlstfound) {

            ArrayList Arlst = new ArrayList();
            Arlst = Arrlstfound;
            ResponseObject response = new ResponseObject();
            int[] TableCountOccurences = Enumerable.Repeat(100,Arlst.Count).ToArray(); // new int[Arlst.Count];
            int[] ColumnCountOccurences = Enumerable.Repeat(100,Arlst.Count).ToArray();
            int[] SubjectCountOccurences = Enumerable.Repeat(100,Arlst.Count).ToArray();
            int j = 0;
            int k = 0;

            for(int i = 0; i < Arlst.Count; i++)
                {
                    if(GetTable((string)Arlst[i]) != 100)
                    {
                        TableCountOccurences[j] = GetTable((string)Arlst[i]);
                        j++;
                    }
                }

                TableCountOccurences = TableCountOccurences.Except(new int[] { 100 }).ToArray();

                if(TableCountOccurences.Length != 0)
                {
                    int maxRepeatedTable = (from item in TableCountOccurences
                                            group item by item into g
                                            orderby g.Count() descending
                                            select g.Key).First();
                    if(maxRepeatedTable != 100)
                    {

                        string[] StringArrayTable = new string[3];
                        StringArrayTable = this.TableSet();
                        response.ParameterOne = StringArrayTable[maxRepeatedTable];
                    }

                }
                else
                {
                    response.ParameterOne = "regular_registration_data";
                }


                if(TableCountOccurences != null && ColumnCountOccurences != null)
                {
                    int indexJump = 0;
                    if(response.ParameterOne == "pro_rata_registration_data")
                    {
                        indexJump = 1;
                    }
                    if(response.ParameterOne == "regular_registration_data")
                    {
                        indexJump = 2;
                    }
                    if(response.ParameterOne == "repeat_registration_data")
                    {
                        indexJump = 3;
                    }

                    for(int i = 0; i < Arlst.Count; i++)
                    {
                        if(GetColumn((string)Arlst[i],indexJump) != 100)
                        {
                            ColumnCountOccurences[k] = GetColumn((string)Arlst[i],indexJump);
                            k++;
                        }
                    }
                    ColumnCountOccurences = ColumnCountOccurences.Except(new int[] { 100 }).ToArray();

                    int maxRepeatedColumn = ColumnCountOccurences.GroupBy(s => s)
                                 .OrderByDescending(s => s.Count())
                                 .First().Key;
                    string[] StringArrayColumn = new string[10];

                    if(indexJump == 1)
                    {
                        StringArrayColumn = this.ColumnSetProRataArr();
                    }
                    if(indexJump == 2)
                    {
                        StringArrayColumn = this.ColumnSetRegularArr();
                    }
                    if(indexJump == 3)
                    {
                        StringArrayColumn = this.ColumnSetRepeatArr();
                    }
                    if(maxRepeatedColumn != 100)
                    {
                        response.ParameterTwo = StringArrayColumn[maxRepeatedColumn];
                    }
                }
                else
                {
                    response.ParameterTwo = "Test";
                }
            return response;

        }

        public string SetFrontEndMassage(string paraOne) {
            string[] ArryNormal = this.ColumnSetNormal();
            string[] ArrySweetened = this.SweetenedColumnSet();

            for(int i = 0; i< ArryNormal.Length; i++) {
                if(ArryNormal[i] == paraOne) {
                    paraOne = ArrySweetened[i];
                    break;
                }
            }
            return paraOne;
        }

        public int CheckSubject (string ParameterOne) {
            try
            {
                int paraSubjectCount = 100;

                string[] StringArray = new string[3];
                StringArray = this.SubjectSet();

                for(int i = 0; i < StringArray.Length; i++)
                {
                    if(ParameterOne.Contains(StringArray[i]))
                    {
                        paraSubjectCount = i;
                        break;
                    }
                }
                return paraSubjectCount;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public int GetTable(string ParameterOne)
        {
            ParameterOne = ParameterOne.Replace(",","");
            try {
                int paraTableCount = 100;

                string[] StringArray = new string[3];
                StringArray = this.TableSetPack();

                for(int i = 0; i < StringArray.Length; i++)
                {
                    if(ParameterOne.Contains(StringArray[i]))
                    {
                        paraTableCount = i;
                        break;
                    }
                }
                return paraTableCount;
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        public int GetColumn(string ParameterOne , int indexJump) {

            try {
                int paraColumnCount = 100;

                if(indexJump == 1)
                {
                    string[] StringArray = new string[6];
                    StringArray = this.ColumnSetProRata();

                    for(int i = 0; i < StringArray.Length; i++)
                    {
                        if(StringArray[i].Contains(ParameterOne))
                        {
                            paraColumnCount = i;
                            break;
                        }
                    }
                }
                if(indexJump == 2)
                {
                    string[] StringArray = new string[8];
                    StringArray = this.ColumnSetRegular();

                    for(int i = 0; i < StringArray.Length; i++)
                    {
                        if(StringArray[i].Contains(ParameterOne))
                        {
                            paraColumnCount = i;
                            break;
                        }
                    }
                }
                if(indexJump == 3)
                {
                    string[] StringArray = new string[3];
                    StringArray = this.ColumnSetRepeat();

                    for(int i = 0; i < StringArray.Length; i++)
                    {
                        if(StringArray[i].Contains(ParameterOne))
                        {
                            paraColumnCount = i;
                            break;
                        }
                    }
                }

                return paraColumnCount;
            }
            catch(Exception ex) {
                throw ex;
            }
        }

        public string[] TableSet() {
            string[] StringArray = new string[3];

            StringArray[0] = "pro_rata_registration_data";
            StringArray[1] = "regular_registration_data";
            StringArray[2] = "repeat_registration_data";

            return StringArray;
        }

        public string[] TableSetPack()
        {
            string[] StringArray = new string[3];

            StringArray[0] = "pro_rata";
            StringArray[1] = "regular";
            StringArray[2] = "repeat";

            return StringArray;
        }

        public string[] ColumnSet() {

            string[] StringArray = new string[20];

            //Regular Columns
            //START
            StringArray[0] = "payment_end_date";
            StringArray[1] = "payment_start_date";
            StringArray[2] = "semester_start_date";
            StringArray[3] = "semester_end_date";
            StringArray[4] = "semester_fee";
            StringArray[5] = "late_payment_date_from";
            StringArray[6] = "late_payment_date_to";
            StringArray[7] = "late_payment_fee";
            //END

            //Pro_Rata Coluns
            //START
            StringArray[8] = "pro_rata_registration_start_date";
            StringArray[9] = "pro_rata_registration_end_date";
            StringArray[10] = "pro_rata_fee";
            StringArray[11] = "last_payment_date_from";
            StringArray[12] = "last_payment_date_to";
            StringArray[13] = "late_payment_fee";
            //END

            //Repeat Columns
            //START
            StringArray[14] = "repeat_registration_start_date";
            StringArray[15] = "repeat_registration_end_date";
            StringArray[16] = "repeat_fee";
            //END

            return StringArray;
        }

        public string[] ColumnSetNormal()
        {

            string[] StringArray = new string[20];

            //Regular Columns
            //START
            StringArray[0] = "payment_end_date";
            StringArray[1] = "payment_start_date";
            StringArray[2] = "semester_start_date";
            StringArray[3] = "semester_end_date";
            StringArray[4] = "semester_fee";
            StringArray[5] = "late_payment_date_from";
            StringArray[6] = "late_payment_date_to";
            StringArray[7] = "late_payment_fee";
            //END

            //Pro_Rata Coluns
            //START
            StringArray[8] = "pro_rata_registration_start_date";
            StringArray[9] = "pro_rata_registration_end_date";
            StringArray[10] = "pro_rata_fee";
            StringArray[11] = "last_payment_date_from";
            StringArray[12] = "last_payment_date_to";
            StringArray[13] = "late_payment_fee";
            //END

            //Repeat Columns
            //START
            StringArray[14] = "repeat_registration_start_date";
            StringArray[15] = "repeat_registration_end_date";
            StringArray[16] = "repeat_fee";
            //END

            //Table list
            //START
            StringArray[17] = "regular_registration_data";
            StringArray[18] = "pro_rata_registration_data";
            StringArray[19] = "repeat_registration_data";
            //END

            return StringArray;
        }

        public string[] SweetenedColumnSet()
        {

            string[] StringArray = new string[20];

            //Regular Columns
            //START
            StringArray[0] = "Payment end date";
            StringArray[1] = "Payment start date";
            StringArray[2] = "Semester start date";
            StringArray[3] = "Semester end date";
            StringArray[4] = "Semester fee";
            StringArray[5] = "Late payment date from";
            StringArray[6] = "Late payment date to";
            StringArray[7] = "Late payment fee";
            //END

            //Pro_Rata Coluns
            //START
            StringArray[8] = "Registration start date";
            StringArray[9] = "Registration end date";
            StringArray[10] = "Fee";
            StringArray[11] = "Last payment date from";
            StringArray[12] = "Last payment date to";
            StringArray[13] = "Late payment fee";
            //END

            //Repeat Columns
            //START
            StringArray[14] = "Registration start date";
            StringArray[15] = "Registration end date";
            StringArray[16] = "Repeat fee";
            //END

            //Table list
            //START
            StringArray[17] = "Regular registration ";
            StringArray[18] = "Pro_Rata registration ";
            StringArray[19] = "Repeat registration ";
            //END

            return StringArray;
        }

        public string[] ColumnSetRegular()
        {

            string[] StringArray = new string[8];

            //Regular Columns
            //START
            StringArray[0] = "end";
            StringArray[1] = "start";
            StringArray[2] = "registration_start_date";
            StringArray[3] = "end_date";
            StringArray[4] = "fee";
            StringArray[5] = "late_payment_date_from";
            StringArray[6] = "late_payment_date_to";
            StringArray[7] = "late_payment_fee";
            //END

            return StringArray;
        }

        public string[] ColumnSetProRata()
        {

            string[] StringArray = new string[6];

            //Pro_Rata Coluns
            //START
            StringArray[0] = "start_date";
            StringArray[1] = "end";
            StringArray[2] = "fee";
            StringArray[3] = "last_from";
            StringArray[4] = "last_to";
            StringArray[5] = "late_payment_fee";
            //END

            return StringArray;
        }

        public string[] ColumnSetRepeat()
        {

            string[] StringArray = new string[3];
            //Repeat Columns
            //START
            StringArray[0] = "start";
            StringArray[1] = "date";
            StringArray[2] = "fee";
            //END

            return StringArray;
        }

        //This is used to take the column real values
        //START
        public string[] ColumnSetRegularArr()
        {

            string[] StringArray = new string[8];

            //Regular Columns
            //START
            StringArray[0] = "payment_end_date";
            StringArray[1] = "payment_start_date";
            StringArray[2] = "semester_start_date";
            StringArray[3] = "semester_end_date";
            StringArray[4] = "semester_fee";
            StringArray[5] = "late_payment_date_from";
            StringArray[6] = "late_payment_date_to";
            StringArray[7] = "late_payment_fee";
            //END

            return StringArray;
        }

        public string[] ColumnSetProRataArr()
        {

            string[] StringArray = new string[6];

            //Pro_Rata Coluns
            //START
            StringArray[0] = "pro_rata_registration_start_date";
            StringArray[1] = "pro_rata_registration_end_date";
            StringArray[2] = "pro_rata_fee";
            StringArray[3] = "last_payment_date_from";
            StringArray[4] = "last_payment_date_to";
            StringArray[5] = "late_payment_fee";
            //END

            return StringArray;
        }

        public string[] ColumnSetRepeatArr()
        {

            string[] StringArray = new string[3];
            //Repeat Columns
            //START
            StringArray[0] = "repeat_registration_start_date";
            StringArray[1] = "repeat_registration_end_date";
            StringArray[2] = "repeat_fee";
            //END

            return StringArray;
        }
        //END

        //This is used to make queries using subjects
        //START
        public string[] SubjectSet()
        {
            string[] StringArray = new string[10];

            //Pro_Rata Columns
            //START
            //StringArray[0] = "MIT";
            //StringArray[1] = "FCS";
            //StringArray[2] = "IPE";
            //StringArray[3] = "ST1";
            //StringArray[4] = "CF";
            //StringArray[5] = "ELS2";
            //StringArray[6] = "English1";
            //StringArray[7] = "DBMS1";
            //StringArray[8] = "DCCN1";
            //StringArray[9] = "ITA";
            //END

            //START
            StringArray[0] = "mit";
            StringArray[1] = "fcs";
            StringArray[2] = "ipe";
            StringArray[3] = "st1";
            StringArray[4] = "cf";
            StringArray[5] = "els2";
            StringArray[6] = "english1";
            StringArray[7] = "dbms1";
            StringArray[8] = "dccn1";
            StringArray[9] = "ita";
            //END

            return StringArray;
        }
        //END
    }
}