report 50563 "Deposit Listing"
{
    ApplicationArea = All;
    Caption = 'Sasra Reports Listing';
    UsageCategory = ReportsAndAnalysis;
    DefaultLayout = RDLC;
    RDLCLayout = './src/Layouts/Deposit Listing.rdlc';
    dataset
    {
        dataitem(SavingsAccount; "Savings Accounts")
        {
            CalcFields = "Balance (LCY)";
            RequestFilterFields = "Member No.", "No.", "Saving Type", "Product Category", "Member Category";
            column(Picture; CompanyInfo.Picture) { }
            column(DepositNumber; "No.")
            {
            }
            column(MemberNo; "Member No.")
            {
            }
            column(MemberName; Name)
            {
            }
            column(IDNo; "ID No.")
            {
            }
            column(DepositType; "Saving Type")
            {
            }
            column(DepositInterest; Interest)
            {
            }
            column(DepositBalance; "New Balance (LCY)")
            {
            }
            column(BranchName; "Global Dimension 2 Code")
            {
            }
            column(DepositName; "Product Name")
            {
            }
            column(ProductCaption; ProductCaption)
            {
            }
            column(AsAt; AsAt)
            {
            }
            dataitem(Member; Members)
            {
                dataitemlink = "No." = field("Member No.");
                column(Sex; Gender)
                {
                }
                column(Date_of_Birth; "Date of Birth")
                { }
                column(TypeofMembership; Type)
                { }
                column(Global_Dimension_2_Code; "Global Dimension 2 Code")
                { }

            }

            trigger OnAfterGetRecord()
            var
                FDAccount: Record "Fixed Deposit Accounts";
                Members: Record Customer;
            begin
                //mAGONDU
                Members.Reset();
                Members.SetRange("No.", SavingsAccount."Member No.");
                IF Members.FindFirst() then
                    Branch := Members."Global Dimension 2 Code";
                //END
                ProductFactory.reset;
                ProductFactory.setrange("Product ID", SavingsAccount."Product Type");
                If ProductFactory.FindFirst() then Interest := ProductFactory."Interest Rate (Max.)";

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Fixed Deposit" then begin
                    FDAccount.Reset();
                    FDAccount.SetRange("Fixed Account No.", SavingsAccount."No.");
                    if FDAccount.FindFirst() then
                        Interest := FDAccount."FD Annual Interest %";
                    if FDAccount."Negotiated Interest %" > 0 then
                        Interest := FDAccount."Negotiated Interest %";
                end;

                if SavingsAccount."Product Category" = SavingsAccount."Product Category"::"Junior Savings" then
                    if SavingsAccount."Child Name" <> '' then
                        SavingsAccount.Name := SavingsAccount."Child Name";

            end;

            trigger OnPreDataItem()
            begin
                if SavingsProduct = '' then
                    Error('Saving product type is required');

                CompanyInfo.Get();
                CompanyInfo.CalcFields(Picture);

                if SavingsProduct = '' then
                    Error('Savings product must be specified.');

                if ProductType.Get(SavingsProduct) then
                    ProductCaption := ProductType.Description + ' Listing';

                SavingsAccount.SetRange("Product Type", SavingsProduct);
                SavingsAccount.SetFilter("Date Filter", '..%1', AsAt);

            end;
        }
    }
    requestpage
    {
        layout
        {
            area(Content)
            {

                field(AsAt; AsAt)
                {
                    ApplicationArea = All;
                    Caption = 'As At';
                    ToolTip = 'Specifies the date to which the report is to be generated.';
                }
                field(SavingsProduct; SavingsProduct)
                {
                    ApplicationArea = All;
                    Caption = 'Product Type';
                    ToolTip = 'Specifies the Product Type to which the report is to be generated.';
                    TableRelation = "Product Setup" where("Product Class" = const(Savings));
                }
            }
        }
        actions
        {
            area(Processing)
            {
            }
        }
    }

    var
        CompanyInfo: Record "Company Information";
        ProductFactory: Record "Product Setup";
        Interest: Decimal;
        AsAt: Date;
        Branch: Text;
        SavingsProduct: Code[20];
        ProductType: Record "Product Setup";
        ProductCaption: Text[50];
}
