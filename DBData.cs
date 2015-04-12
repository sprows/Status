using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Data;
using System.Data.SqlClient;
using System.Text;

namespace SC
{
    public class DBData
    {

    private string _connectionString = string.Empty;
    private string _sortColumns = string.Empty;
    private string _searchCritera = string.Empty;
    private string _commented = string.Empty;
    private string _liked = string.Empty;
    private string _sessionID = string.Empty;
    private int _count;

    public DBData()
	{
        _connectionString = GetConnection();
	}

    public string SortColumns {
        get { return _sortColumns; }
        set { _sortColumns = value; }
    }

    public string SearchCritera
    {
        get { return _searchCritera; }
        set { _searchCritera = value; }
    }

    public string Commented
    {
        get { return _commented; }
        set { _commented = value; }
    }

    public string Liked
    {
        get { return _liked; }
        set { _liked = value; }
    }

    public string SessionID
    {
        get { return _sessionID; }
        set { _sessionID = value; }
    }

    public DataSet GetComments(string StatusID)
    {

        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;
                    cmd.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@StatusID"].Value = StatusID;
                    sql.Append("SELECT * FROM Comments where StatusID = @StatusID order by CommentTime");
                    cmd.CommandText = sql.ToString();
                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public string GetStatus(string StatusID)
    {

        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
               
                    cmd.Connection = conn;
                    cmd.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@StatusID"].Value = StatusID;
                    sql.Append("SELECT message FROM StatusMessages where StatusID = @StatusID");
                    cmd.CommandText = sql.ToString();

                    return cmd.ExecuteScalar().ToString();
            }
        }
    }

    public DataSet GetLikes(string StatusID)
    {

        StringBuilder sql = new StringBuilder();


        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {

                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@StatusID"].Value = StatusID;

                    sql.Append("SELECT * FROM Likes where StatusID = @StatusID order by LikeID desc");

                    cmd.CommandText = sql.ToString();


                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;

                }

            }

        }
    }

   
    public string GetStatusCount(string SessionID)
    {
        StringBuilder sql = new StringBuilder();

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                cmd.Parameters["@SessionID"].Value = SessionID;

                sql.Append("select count(statusID) from StatusMessages where FBUID = @SessionID ");

                cmd.CommandText = sql.ToString();
                cmd.Connection = conn;

                return Convert.ToString(cmd.ExecuteScalar());
            }
        }
    }

    
    public DataSet GetTopComments(string SessionID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                    cmd.Parameters["@SessionID"].Value = SessionID;

                    sql.Append("select top 10 s.message,s.StatusID, COUNT(c.CommentID) as MessageCount from StatusMessages s,Comments c where s.StatusID = c.StatusID ");
                    sql.Append("and FBUID = @SessionID group by s.message, s.StatusID order by COUNT(c.CommentID) desc");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public DataSet GetDistinctListOfCommentedFriends(string FBUID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@FBUID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@FBUID"].Value = FBUID;

                    sql.Append("select distinct FromFBUID, FBFrom from ");
                    sql.Append("(select c.FromFBUID, c.FBFrom from dbo.Comments c, StatusMessages s where c.statusid = s.statusid ");
                    sql.Append("and s.fbUID = @FBUID) t order by FBFrom");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public DataSet GetDistinctListOfLikedFriends(string FBUID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@FBUID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@FBUID"].Value = FBUID;

                    sql.Append("select distinct FBLikeID, FBFrom from ");
                    sql.Append("(select c.FBLikeID, c.FBFrom from dbo.Likes c, StatusMessages s where c.statusid = s.statusid ");
                    sql.Append("and s.fbUID = @FBUID) t order by FBFrom");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public DataSet GetTopFriends(string SessionID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@SessionID"].Value = SessionID;

                    sql.Append("select top 10 c.FromFBUID, c.FBFrom, COUNT(c.FBCommentID) as PostCount from Comments c, StatusMessages s ");
                    sql.Append("where s.statusid = c.statusid and FBUID = @SessionID group by c.FromFBUID, c.FBFrom order by COUNT(c.FBCommentID) desc");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }


    public bool InsertStats(string FBUID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@FBUID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@FBUID"].Value = FBUID;

                    sql.Append("select fbuid, sum(likes) likes, sum(CommentCount) CommentCount,  count(*) Posts ");
                    sql.Append(" from StatusMessages where fbuid = @FBUID group by fbuid");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);
                    
                    if (ds.Tables[0] != null)
                    {
                        if (ds.Tables[0].Rows.Count > 0)
                        {
                            //Insert
                            InsertStatusStats(FBUID, Convert.ToInt32(ds.Tables[0].Rows[0]["likes"]), Convert.ToInt32(ds.Tables[0].Rows[0]["CommentCount"]), Convert.ToInt32(ds.Tables[0].Rows[0]["Posts"]));
                        }
                    }

                    return true;
                }
            }
        }
    }

    public bool InsertStatusStats(string fbUID, int Likes, int CommentCount, int Posts)
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            StringBuilder sql = new StringBuilder();

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;

                cmd.Parameters.Add(new SqlParameter("@fbUID", SqlDbType.VarChar, 30));
                cmd.Parameters["@fbUID"].Value = fbUID;

                cmd.Parameters.Add(new SqlParameter("@Likes", SqlDbType.Int));
                cmd.Parameters["@Likes"].Value = Likes;

                cmd.Parameters.Add(new SqlParameter("@CommentCount", SqlDbType.Int));
                cmd.Parameters["@CommentCount"].Value = CommentCount;

                cmd.Parameters.Add(new SqlParameter("@Posts", SqlDbType.Int));
                cmd.Parameters["@Posts"].Value = Posts;

             
                sql.Append("INSERT INTO [dbo].[SummaryStats]([FBUID],[Likes],[CommentCount],[Posts],[CreatedDate]) ");
                sql.Append("VALUES (@fbUID,@Likes,@CommentCount,@Posts,getdate())");

                cmd.CommandText = sql.ToString();
                cmd.ExecuteNonQuery();

       
                return true;

            }

        }

    }

    public DataSet GetStatusStats()
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    sql.Append("SELECT [FBUID],[Likes],[CommentCount],[Posts],[CreatedDate] ");
                    sql.Append("FROM [dbo].[SummaryStats] order by CreatedDate desc ");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public DataSet GetStatusStat(string FBUID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@FBUID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@FBUID"].Value = FBUID;

                    sql.Append("select fbuid, sum(likes) likes, sum(CommentCount) CommentCount,  count(*) Posts ");
                    sql.Append(" from StatusMessages where fbuid = @FBUID group by fbuid");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }



   

    public DataSet GetTopLiked(string SessionID)
    {
        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {
                    cmd.Connection = conn;

                    cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar, 30));
                    cmd.Parameters["@SessionID"].Value = SessionID;

                    sql.Append("select top 10 c.FBLikeID,c.FBFrom, COUNT(c.LikeID) as PostLike from Likes c, StatusMessages s ");
                    sql.Append("where s.statusid = c.statusid and FBUID = @SessionID group by c.FBLikeID, c.FBFrom order by COUNT(c.LikeID) desc");

                    cmd.CommandText = sql.ToString();

                    sa.SelectCommand = cmd;
                    DataSet ds = new DataSet();
                    sa.Fill(ds);

                    return ds;
                }
            }
        }
    }

    public int GetFriendCountWhoCommented(string SessionID)
    {
        StringBuilder sql = new StringBuilder();

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                cmd.Parameters["@SessionID"].Value = SessionID;

                sql.Append("select count(distinct FromFBUID) from Comments c, StatusMessages s ");
                sql.Append("where s.statusid = c.statusid  and FBUID = @SessionID ");

                cmd.CommandText = sql.ToString();
                cmd.Connection = conn;

                return (int)cmd.ExecuteScalar();
            }
        }
    }

    public int GetFriendCountWhoLiked(string SessionID)
    {
        StringBuilder sql = new StringBuilder();

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                cmd.Parameters["@SessionID"].Value = SessionID;

                sql.Append("select count(distinct FBLikeID) from likes c, StatusMessages s ");
                sql.Append("where s.statusid = c.statusid  and FBUID = @SessionID ");

                cmd.CommandText = sql.ToString();
                cmd.Connection = conn;

                return (int)cmd.ExecuteScalar();
            }
        }
    }


    public DataSet GetStatusMessages(int startRow, int pageSize, string sortColumns) {

        StringBuilder sql = new StringBuilder();

        if (sortColumns.Length > 0)
            _sortColumns = sortColumns;

        if (_sessionID.Length == 0)
        {
            return null;
        }

        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            using (SqlCommand cmd = new SqlCommand())
            {
                using (SqlDataAdapter sa = new SqlDataAdapter())
                {

                cmd.Connection = conn;

                cmd.Parameters.Add(new SqlParameter("@startRow", SqlDbType.Int));
                cmd.Parameters["@startRow"].Value = startRow;

                cmd.Parameters.Add(new SqlParameter("@ResultSetRowNumber", SqlDbType.Int));
                cmd.Parameters["@ResultSetRowNumber"].Value = startRow + pageSize;

                cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                cmd.Parameters["@SessionID"].Value = _sessionID;

                cmd.Parameters.Add(new SqlParameter("@commented", SqlDbType.VarChar,30));
                cmd.Parameters["@commented"].Value = _commented;

                cmd.Parameters.Add(new SqlParameter("@liked", SqlDbType.VarChar, 30));
                cmd.Parameters["@liked"].Value = _liked;

               

                    sql.Append("SELECT * FROM ( ");
                    sql.Append("SELECT s.StatusID, s.SessionID, s.FBUID, s.FBMessageID, s.Message,s.MessageTime,s.Likes,s.CommentCount ");
                    sql.AppendFormat(", ROW_NUMBER() OVER (ORDER BY {0}) AS ResultSetRowNumber ", _sortColumns);
                    sql.Append("FROM StatusMessages s ");
                    sql.Append("where FBUID=@SessionID ");

                    if (_commented.Length > 0)
                    {
                        sql.Append("and StatusID in (select StatusID from Comments where FromFBUID = @commented) ");
                    }

                    if (_liked.Length > 0)
                    {
                        sql.Append("and StatusID in (select StatusID from likes where FBLikeID = @liked) ");
                    }

                    if (_searchCritera.Length > 0)
                    {
                        sql.Append(" and message like '%" + _searchCritera + "%' ");
                    }

                
                    sql.Append(" ) AS PagedResults  ");
                    sql.Append(" WHERE ResultSetRowNumber > @startRow AND ResultSetRowNumber <= @ResultSetRowNumber ");



                cmd.CommandText = sql.ToString();
                

                sa.SelectCommand = cmd;
                DataSet ds = new DataSet();
                sa.Fill(ds);

                if (ds != null)
                {
                    if (ds.Tables.Count > 0)
                    {
                        _count = ds.Tables[0].Rows.Count;
                    }
                }

                return ds;

                }
            }
        }
    }


    public int GetRowCount()
    {

        StringBuilder sql = new StringBuilder();
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();
            using (SqlCommand cmd = new SqlCommand())
            {

                cmd.Connection = conn;

                cmd.Parameters.Add(new SqlParameter("@SessionID", SqlDbType.VarChar,30));
                cmd.Parameters["@SessionID"].Value = _sessionID;

                cmd.Parameters.Add(new SqlParameter("@commented", SqlDbType.VarChar, 30));
                cmd.Parameters["@commented"].Value = _commented;

                cmd.Parameters.Add(new SqlParameter("@liked", SqlDbType.VarChar, 30));
                cmd.Parameters["@liked"].Value = _liked;

                sql.Append("SELECT count(*) FROM ( ");
                sql.Append("SELECT s.StatusID, s.SessionID, s.FBUID, s.FBMessageID, s.Message,s.MessageTime,s.Likes,s.CommentCount ");
                sql.AppendFormat(", ROW_NUMBER() OVER (ORDER BY {0}) AS ResultSetRowNumber ", _sortColumns);
                sql.Append("FROM StatusMessages s ");
                sql.Append("where FBUID=@SessionID ");

                if (_commented.Length > 0)
                {
                    sql.Append("and StatusID in (select StatusID from Comments where FromFBUID = @commented) ");
                }

                if (_liked.Length > 0)
                {
                    sql.Append("and StatusID in (select StatusID from likes where FBLikeID = @liked) ");
                }

                if (_searchCritera.Length > 0)
                {
                    sql.Append(" and message like '%" + _searchCritera + "%' ");
                }

                sql.Append(" ) AS PagedResults  ");

                cmd.CommandText = sql.ToString();

                return (int)cmd.ExecuteScalar();
            }
        }
    }

    //public int GetRowCount() {
    //    using (SqlConnection conn = new SqlConnection(_connectionString)) {
    //        conn.Open();
    //        using (SqlCommand cmd = new SqlCommand("SELECT COUNT(*) FROM StatusMessages", conn))
    //        {
    //            return (int)cmd.ExecuteScalar();
    //        }
    //    }
    //}


    public void CleanUp()
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;

                cmd.CommandText = "delete from dbo.Comments where CreatedDate < dateadd(mi,-30,getdate())";
                cmd.ExecuteNonQuery();

                cmd.CommandText = "delete from dbo.Likes where CreatedDate < dateadd(mi,-30,getdate())";
                cmd.ExecuteNonQuery();

                cmd.CommandText = "delete from dbo.StatusMessages where CreatedDate < dateadd(mi,-30,getdate())";
                cmd.ExecuteNonQuery();

            }
        }
    }

    public string InsertStatus( string fbUID, string FBMessageID, int CommentCount, int Likes, string Message, DateTime MessageTime)
    {
         using (SqlConnection conn = new SqlConnection(_connectionString))
         {
             conn.Open();

             using (SqlCommand cmd = new SqlCommand())
             {
                 cmd.Connection = conn;

                 cmd.Parameters.Add(new SqlParameter("@fbUID",SqlDbType.VarChar, 30));
                 cmd.Parameters["@fbUID"].Value = fbUID;

                 cmd.Parameters.Add(new SqlParameter("@FBMessageID",SqlDbType.VarChar, 30));
                 cmd.Parameters["@FBMessageID"].Value = FBMessageID;

                 cmd.Parameters.Add(new SqlParameter("@CommentCount",SqlDbType.Int));
                 cmd.Parameters["@CommentCount"].Value = CommentCount;

                 cmd.Parameters.Add(new SqlParameter("@Likes",SqlDbType.Int));
                 cmd.Parameters["@Likes"].Value = Likes;

                 cmd.Parameters.Add(new SqlParameter("@Message",SqlDbType.VarChar,2000));
                 cmd.Parameters["@Message"].Value = Message;

                 cmd.Parameters.Add(new SqlParameter("@MessageTime",SqlDbType.DateTime));
                 cmd.Parameters["@MessageTime"].Value = MessageTime;

                 string SQL = "";
                 string ID = "";

                 SQL = "Select StatusID from StatusMessages where FBMessageID = @FBMessageID";
                 cmd.CommandText = SQL;
                 object rst = cmd.ExecuteScalar();

                 if (rst == null)
                 {
                     SQL = "INSERT INTO [dbo].[StatusMessages]([FBUID],[FBMessageID],[Message],[MessageTime],[Likes],[CommentCount],[CreatedDate]) ";
                     SQL = SQL + "VALUES(@fbUID,@FBMessageID,@Message,@MessageTime,@Likes,@CommentCount,getdate()); SELECT SCOPE_IDENTITY()";

                     cmd.CommandText = SQL;
                     ID = cmd.ExecuteScalar().ToString();

                 }
                 else
                 {
                     ID = rst.ToString();
                 }

                 return ID;

             }

         }

    }

    public string InsertComment(string Comment, int CommentLikes, DateTime CommentTime, string FBCommentID, string FBFrom,string FromFBUID, int StatusID)
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;

                cmd.Parameters.Add(new SqlParameter("@Comment", SqlDbType.VarChar, 2000));
                cmd.Parameters["@Comment"].Value = Comment;

                cmd.Parameters.Add(new SqlParameter("@CommentLikes", SqlDbType.Int));
                cmd.Parameters["@CommentLikes"].Value = CommentLikes;

                   cmd.Parameters.Add(new SqlParameter("@CommentTime", SqlDbType.DateTime));
                cmd.Parameters["@CommentTime"].Value = CommentTime;

                cmd.Parameters.Add(new SqlParameter("@FBCommentID", SqlDbType.VarChar,30));
                cmd.Parameters["@FBCommentID"].Value = FBCommentID;

                cmd.Parameters.Add(new SqlParameter("@FBFrom", SqlDbType.VarChar, 50));
                cmd.Parameters["@FBFrom"].Value = FBFrom;

                cmd.Parameters.Add(new SqlParameter("@FromFBUID", SqlDbType.VarChar, 30));
                cmd.Parameters["@FromFBUID"].Value = FromFBUID;

                cmd.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.Int));
                cmd.Parameters["@StatusID"].Value = StatusID;

             

                string SQL = "";

                SQL = "Select CommentID from Comments where FBCommentID = @FBCommentID";
                cmd.CommandText = SQL;
                object rst = cmd.ExecuteScalar();
                if (rst == null)
                {

                    SQL = "INSERT INTO [dbo].[Comments]([StatusID],[FBCommentID],[FBFrom],[FromFBUID],[Comment],[CommentTime],[CommentLikes],[CreatedDate]) ";
                    SQL = SQL + "VALUES(@StatusID,@FBCommentID,@FBFrom,@FromFBUID,@Comment,@CommentTime,@CommentLikes,getdate())";

                    cmd.CommandText = SQL;
                    cmd.ExecuteNonQuery();
                }

                return "";

            }

        }

    }

    public string InsertLike(string FBFrom, string FBLikeID, int StatusID)
    {
        using (SqlConnection conn = new SqlConnection(_connectionString))
        {
            conn.Open();

            using (SqlCommand cmd = new SqlCommand())
            {
                cmd.Connection = conn;


                cmd.Parameters.Add(new SqlParameter("@FBFrom", SqlDbType.VarChar, 50));
                cmd.Parameters["@FBFrom"].Value = FBFrom;

                cmd.Parameters.Add(new SqlParameter("@FBLikeID", SqlDbType.VarChar, 30));
                cmd.Parameters["@FBLikeID"].Value = FBLikeID;

                cmd.Parameters.Add(new SqlParameter("@StatusID", SqlDbType.Int));
                cmd.Parameters["@StatusID"].Value = StatusID;



                string SQL = "";

                SQL = "Select LikeID from Likes where FBLikeID = @FBLikeID and StatusID = @StatusID";
                cmd.CommandText = SQL;
                object rst = cmd.ExecuteScalar();
                if (rst == null)
                {

                    SQL = "INSERT INTO [dbo].[Likes]([StatusID],[FBFrom],[FBLikeID],[CreatedDate]) ";
                    SQL = SQL + "VALUES(@StatusID,@FBFrom,@FBLikeID,getdate())";

                    cmd.CommandText = SQL;
                    cmd.ExecuteNonQuery();
                }

                return "";

            }

        }

    }

    public DataSet GetDataSet(string sql) {
        DataSet ds = new DataSet();

        using (SqlConnection conn = new SqlConnection(_connectionString)) {
            conn.Open();
            using (SqlDataAdapter da = new SqlDataAdapter(sql, conn)) {
                da.Fill(ds);
            }
        }

        return ds;
    }

    private string AssembleSelectSql() {
        StringBuilder sql = new StringBuilder();

        sql.Append("SELECT StatusID, SessionID, FBUID, FBMessageID, Message,MessageTime,Likes,CommentCount ");
        sql.Append(" FROM StatusMessages");

        

        return sql.ToString();
    }

    private string AssemblePagedSelectSql(int startRow, int pageSize) {
        StringBuilder sql = new StringBuilder();

        // The "core" select statement is: "SELECT EmployeeId, FirstName, MiddleName, LastName, JobTitle FROM HumanResources.vEmployee"
        // The rest of this code inserts a RowNumber column into the result set and wraps the entire select with paging conditions.
        sql.Append("SELECT * FROM (");
        sql.Append("SELECT StatusID, SessionID, FBUID, FBMessageID, Message,MessageTime,Likes,CommentCount");
        sql.AppendFormat(", ROW_NUMBER() OVER (ORDER BY {0}) AS ResultSetRowNumber", _sortColumns);
        sql.Append(" FROM StatusMessages) AS PagedResults");
        sql.AppendFormat(" WHERE ResultSetRowNumber > {0} AND ResultSetRowNumber <= {1}", startRow.ToString(), (startRow + pageSize).ToString());
        
        if (_searchCritera.Length > 0)
        {
            sql.Append(" and message like '%" + _searchCritera + "%' ");
        }

        return sql.ToString();
    }

    private string GetConnection() {
        return System.Web.Configuration.WebConfigurationManager.AppSettings["StatusHistory"];
    }
    }
}