namespace CentralDB.CentralDB;

using Microsoft.Finance.Dimension;
using System.Security.User;

pageextension 50085 "Dimension Set ID Entries" extends "Edit Dimension Set Entries"
{
    actions
    {
        addfirst(processing)
        {
            action("Load Dimensions")
            {
                ApplicationArea = Basic;
                Image = New;
                Promoted = true;
                PromotedCategory = Process;
                PromotedIsBig = true;
                trigger OnAction()
                var
                    myInt: Integer;
                    UserSetup: Record "User Setup";
                    DimEntries: Record "Dimension Set Entry" temporary;
                    Dim: Record Dimension;
                begin

                    Dim.Reset();
                    if Dim.FindSet() then begin
                        //DimEntries.Reset();
                        //if DimEntries.Find('-') then DimEntries.Delete();
                        repeat
                            DimEntries.Init();
                            DimEntries."Dimension Code" := Dim.Code;
                            if DimEntries.Insert() then;
                        until Dim.Next() = 0;
                    end;
                end;

            }
        }
    }
}
