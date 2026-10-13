page 50569 "AdminSecretaryModule"

{
    Caption = 'Admin Secretary Role Center', Comment = 'Use same translation as ''Profile Description'' (if applicable)';
    PageType = RoleCenter;



    layout
    {
        area(rolecenter)
        {
            part(SaccoNewsActivities; "Sacco News Activities Part")
            {
                ApplicationArea = RelationshipMgmt;
            }
            part(Control13; "Common Activities")
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
        area(sections)
        {
            group("Overtime Management")
            {
                action("Overtime List")
                {
                    ApplicationArea = RelationshipMgmt;
                    RunObject = Page "HR Overtime List";
                }
                action("Overtime List - Converted")
                {
                    ApplicationArea = RelationshipMgmt;
                    RunObject = Page "HR Overtime List - Converted";
                }
                action("Overtime Rates")
                {
                    ApplicationArea = RelationshipMgmt;
                    RunObject = Page "HR Overtime Rates List";
                }
            }
        }
    }



}
