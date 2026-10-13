/// <summary>
/// Page Super Admin Role Center (ID 52188687).
/// </summary>
Page 50067 "CEO Role Center"
{
    Caption = 'CEO Role Center', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;

    layout
    {
        area(rolecenter)
        {
            part(Control60; "Headline RC Relationship Mgt.")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control1; "Loan Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(CategoriesPieChart; "Categories Chart")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control12; "Member Activites")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control56; "User Tasks Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }

            part("Emails"; "Email Activities")
            {
                ApplicationArea = Basic, Suite;
            }
            part(ApprovalsActivities; "Approvals Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control45; "Self Service")
            {
                ApplicationArea = RelationshipMgmt;
            }
            /*part(Control16; "Team Member Activities")
            {
                ApplicationArea = RelationshipMgmt;
            }*/
        }
    }

    actions
    {
        area(reporting)
        {

        }

        area(sections)
        {


            group(Membership)
            {
                action(Action64)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Member List';
                    Image = "Order";


                    RunObject = Page "Member List";
                    ToolTip = 'List of all SACCO Members';
                }
                action(MAccounts)
                {
                    ApplicationArea = RelationshipMgmt;
                    Caption = 'Accounts List';
                    Image = CustomerContact;


                    RunObject = Page "Member Accounts List";
                }

            }

        }
    }
}