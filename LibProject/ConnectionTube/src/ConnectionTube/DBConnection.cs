using System;
using System.Linq;

namespace ConnectionTube
{
    //*************************************************************************************************************************************************************************//
    //******************* Please respect the copyright of the owner. Tharusha shehan Edirisooriya [Bsc. Software Engineer (University of Moratuwa, Sri Lanka)] ****************//
    //*************************************************************************************************************************************************************************//
    public class DBConnection
    {
        static string sqllocalConnectionString = ConfigurationManager.ConnectionStrings["BPDTSysEntities"].ConnectionString.ToString();

        //Select one record from Database table
        public static ArrayList selectRecord(string query)
        {
            try
            {
                using(SqlConnection conn = new SqlConnection(sqllocalConnectionString))
                {
                    using(SqlCommand cmd = new SqlCommand(query,conn))
                    {

                        conn.Open();
                        using(SqlDataReader dr = cmd.ExecuteReader())
                        {

                            ArrayList resultArray_toReturn = new ArrayList();

                            int j = 0;
                            int i = dr.FieldCount;

                            if(dr.HasRows)
                            {
                                while(dr.Read())
                                {
                                    for(j = 0; j <= (i - 1); j++)
                                    {
                                        resultArray_toReturn.Add(dr[j].ToString());
                                    }
                                }
                            }


                            return resultArray_toReturn;

                        }
                    }
                }

            }
            catch(Exception ex)
            {
                throw ex;
            }
        }

        //Select multiple records from Database table
        public static DataTable selectRecords(string query,string[] parameterNames = null,Object[] parameterValues = null,string conName = null)
        {
            try
            {
                using(DataTable dt = new DataTable())
                {
                    if(conName == null)
                    {
                        using(SqlConnection conn = new SqlConnection(sqllocalConnectionString))
                        {
                            using(SqlDataAdapter da = new SqlDataAdapter())
                            {
                                using(SqlCommand cmd = new SqlCommand(query,conn))
                                {
                                    if(parameterNames != null)
                                    {

                                        for(int i = 0; i <= parameterNames.Length - 1; i++)
                                        {
                                            cmd.Parameters.AddWithValue(parameterNames[i],parameterValues[i]);
                                        }
                                        cmd.CommandTimeout = 0;
                                        cmd.CommandType = CommandType.StoredProcedure;


                                    }


                                    da.SelectCommand = cmd;
                                    conn.Open();
                                    cmd.CommandTimeout = 0;
                                    da.SelectCommand.ExecuteNonQuery();
                                    da.Fill(dt);

                                    return dt;
                                }

                            }
                        }
                    }
                    else
                    {
                        using(SqlConnection conn = new SqlConnection(sqllocalConnectionString))
                        {
                            using(SqlDataAdapter da = new SqlDataAdapter())
                            {
                                using(SqlCommand cmd = new SqlCommand(query,conn))
                                {
                                    if(parameterNames != null)
                                    {

                                        for(int i = 0; i <= parameterNames.Length - 1; i++)
                                        {
                                            cmd.Parameters.AddWithValue(parameterNames[i],parameterValues[i]);
                                        }

                                        cmd.CommandType = CommandType.StoredProcedure;


                                    }


                                    da.SelectCommand = cmd;
                                    conn.Open();
                                    cmd.CommandTimeout = 0;
                                    da.SelectCommand.ExecuteNonQuery();
                                    da.Fill(dt);

                                    return dt;
                                }

                            }
                        }
                    }
                }

            }
            catch(Exception ex)
            {
                throw ex;
            }

        }

        //Sql datatable insert at once to Database table
        public static void PerformBulkCopy(DataTable dt,string dest)
        {
            try
            {
                using(SqlConnection conn = new SqlConnection(sqllocalConnectionString))
                {
                    using(SqlBulkCopy bulkCopy = new SqlBulkCopy(conn))
                    {
                        for(int i = 0; i < dt.Rows.Count; i++)
                        {
                            for(int jh = 0; jh < dt.Columns.Count; jh++)
                            {
                                string number = dt.Rows[i][jh].ToString();
                            }
                        }
                        conn.Open();
                        bulkCopy.DestinationTableName = dest;
                        bulkCopy.WriteToServer(dt);
                    }
                }
            }
            catch(Exception ex)
            {
                throw ex;
            }
        }
    }
}