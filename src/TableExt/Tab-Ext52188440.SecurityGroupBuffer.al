namespace Wanandage.Wanandage;

using System.Security.AccessControl;
using System.Security.User;

tableextension 50084 "Security Group Buffer" extends "Security Group Buffer"
{
    fields
    {
        field(50050; Type; Option)
        {
            OptionMembers = " ","File Movement";
        }
        field(50051; Supervisor; Code[50])
        {
            TableRelation = "User Setup";
        }
    }
}
