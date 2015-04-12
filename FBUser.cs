using System.Configuration;
using System;
/// <summary>
/// Summary description for FBUser
/// </summary>
[Serializable]
public class FBUser
{
    public FBUser()
    {

    }

    public string UID { get; set; }
    public string FirstName { get; set; }
    public string LastName { get; set; }

}
