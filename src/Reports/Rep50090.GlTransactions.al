namespace UnitedWomen_Production.UnitedWomen_Production;

using Microsoft.Finance.GeneralLedger.Ledger;
using System.Utilities;

report 50090 "Gl Transactions"
{
    Caption = 'Deposit Mobilization';
    UsageCategory = ReportsAndAnalysis;
    ApplicationArea = All;
    DefaultRenderingLayout = GLTransactions;

    dataset
    {
        dataitem(Integer; Integer)
        {
            column(Posting_Date; GLQuery.PostingDate) { }
            column(Document_No_; GLQuery.DocumentNo) { }
            column("Amount"; GLQuery.Amount) { }
            column("CreditAmount"; GLQuery.CreditAmount) { }
            column(PostedBy; GLQuery.User_ID) { }
            column(Channel; GLQuery.Channel) { }
            column("Description"; GLQuery.Description) { }
            column(MemmberNo; GLQuery.Member_No_) { }

            trigger OnPreDataItem()
            begin
                if (StartDate <> 0D) and (EndDate <> 0D) then
                    GLQuery.SetRange(PostingDate, StartDate, EndDate);
                if TChannel <> TChannel::" " then
                    GLQuery.SetRange(Channel, TChannel);
                if ProductCategory <> ProductCategory::" " then
                    GLQuery.SetRange(Product_Category, ProductCategory);
                GLQuery.Open();
            end;

            trigger OnAfterGetRecord()
            begin
                if not GLQuery.Read() then
                    CurrReport.Break();
            end;
        }
    }

    requestpage
    {
        layout
        {
            area(content)
            {
                group(Group)
                {
                    field("Start Date"; StartDate) { ApplicationArea = All; }
                    field("End Date"; EndDate) { ApplicationArea = All; }
                    field(Channel; TChannel) { ApplicationArea = All; }
                    field(ProductCategory; ProductCategory) { ApplicationArea = All; }
                }
            }
        }
    }

    rendering
    {
        layout(GLTransactions)
        {
            Type = RDLC;
            LayoutFile = './src/Layouts/GL Transactions.rdlc';
        }
    }

    var
        StartDate: Date;
        EndDate: Date;
        ProductCategory: Option " ","Registration Fee","Share Capital","Deposit Contribution","Benevolent Fund","Unallocated Fund","Dividend Account","Micro Member Deposit","Micro Group Deposit","Ordinary Savings","Holiday Savings","School Fee","Fixed Deposit","Junior Savings",Welfare,Housing,"Virtual Account","FOSA Shares",Business,Jipange,"Agent Float","Agent Commission",Investment,Jiajiri,"Salary Account","MFI Deposit";
        TChannel: Enum "Transaction Channel";
        GLQuery: Query "GL Transacations Query";

}