page 50351 "Calwide Migrations"
{
    Caption = 'Calwide Migrations';
    PageType = List;
    //SourceTable = "";

    layout
    {
        area(content)
        {

        }


    }


    actions
    {
        area(processing)
        {
            group(ActionGroup19)
            {
            }
            action("Import Paybill COA")
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = XMLport "Import Chart of Accounts";
            }
            action(ModifyCreditAcc)
            {
                ApplicationArea = Basic;
                Image = Import;
                Promoted = true;
                PromotedCategory = Process;
                RunObject = report "Modify Credit Account";
            }
        }
    }
}