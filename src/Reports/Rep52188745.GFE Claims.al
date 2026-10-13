namespace CentralDB.CentralDB;
using Microsoft.Foundation.Company;

report 50419 "GFE Claims"
{
    Caption = 'GFE Claims';
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/GFE Claims.rdlc';
    UsageCategory = ReportsandAnalysis;
    dataset
    {
        dataitem(BBFEntitlementHeader; "BBF Entitlement Header")
        {
            RequestFilterFields = Payed, Date, "Member No";
            column(Amount; Amount)
            {
            }
            column(CapturedBy; "Captured By")
            {
            }
            column(CollectorMobileNo; "Collector Mobile No.")
            {
            }
            column(CollectorName; "Collector Name")
            {
            }
            column(CollectorRelationship; "Collector Relationship")
            {
            }
            column(Date; "Date")
            {
            }
            column(MemberNo; "Member No")
            {
            }
            column(Payed; Payed)
            {
            }
            column(Posted; Posted)
            {
            }
            column(PrincipalName; Memb.Name)
            {
            }
            column(CompName; Company.Name)
            {
            }
            column(CompAddress; Company.Address)
            {
            }
            column(CompPic; Company.Picture)
            {
            }
            dataitem(BBFEntitlementLines; "BBF Entitlement Lines")
            {
                DataItemLink = "Header No" = field("No.");
                column(BBF_Entitlement_Claimed; "BBF Entitlement Claimed")
                {
                }
                column(Name; Name)
                {
                }
                column(Date_of_Birth; "Date of Birth")
                {
                }
                column(Telephone; Telephone)
                {
                }
                column(Email; Email)
                {
                }
                column(Death_Certificate_No_; "Death Certificate No.")
                {
                }
                column(Claim_Type; "Claim Type")
                {
                }
            }
            trigger OnAfterGetRecord()

            begin
                if Memb.Get("Member No") then;
            end;
        }
    }
    requestpage
    {
        layout
        {
            area(content)
            {
                group(GroupName)
                {
                }
            }
        }
        actions
        {
            area(processing)
            {
            }
        }
    }
    trigger OnPreReport()
    begin
        Company.Get;
        Company.CalcFields(Company.Picture);
    end;

    var
        Memb: Record Members;
        Company: Record "Company Information";
}
