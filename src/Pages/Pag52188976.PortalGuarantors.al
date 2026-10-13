namespace CentralDB.CentralDB;

page 50678 "Portal Guarantors"
{
    ApplicationArea = All;
    Caption = 'Portal Guarantors';
    PageType = List;
    SourceTable = "Portal Guarantors";
    DeleteAllowed = true;
    InsertAllowed = true;
    Editable = true;
    UsageCategory = Lists;

    layout
    {
        area(content)
        {
            repeater(General)
            {
                field("Guarantor Mobile No."; Rec."Guarantor Mobile No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Mobile No. field.';
                }
                field(Collateral; Rec.Collateral)
                {
                    ToolTip = 'Specifies the value of the Guarantor Member No. field.';
                }
                field("Guarantor Member No."; Rec."Guarantor Member No.")
                {
                    ToolTip = 'Specifies the value of the Guarantor Member No. field.';
                }
                field("Loan Product"; Rec."Loan Product")
                {
                    ToolTip = 'Specifies the value of the Loan Product field.';
                }
                field("Loan Product Name"; Rec."Loan Product Name")
                {
                    ToolTip = 'Specifies the value of the Loan Product Name field.';
                }
                field("Guarantor Name"; Rec."Guarantor Name")
                {
                    ToolTip = 'Specifies the value of the Guarantor Name field.';
                }
                field("Guarantor Accepted"; Rec."Guarantor Accepted")
                {
                    ToolTip = 'Specifies the value of the Guarantor Accepted field.';
                }
                field("Guarantor Response Date"; Rec."Guarantor Response Date")
                {
                    ToolTip = 'Specifies the value of the Guarantor Response Date field.';
                }
                field("Guarantor Response Time"; Rec."Guarantor Response Time")
                {
                    ToolTip = 'Specifies the value of the Guarantor Response Time field.';
                }
                field(Status; Rec.Status)
                {
                    ToolTip = 'Specifies the value of the Status field.';
                }
                field("Amount Guaranteed"; Rec."Amount Guaranteed")
                {
                    ToolTip = 'Specifies the value of the Amount Guaranteed field.';
                }
                field("Loan Status"; Rec."Loan Status")
                {
                    ToolTip = 'Specifies the value of the Loan Status field.';
                }
                field("Blob Name"; Rec."Blob Name")
                {
                    ToolTip = 'Specifies the value of the Blob Name field.';
                }
                field("Blob Url"; Rec."Blob Url")
                {
                    ToolTip = 'Specifies the value of the Blob Url field.';
                }
            }
        }
    }


    actions
    {
        area(navigation)
        {

            action(ShowDocument)
            {
                Caption = 'Show Document';
                trigger OnAction()
                var
                    BlobStorageHandler: Codeunit "Azure Blob Storage Handler";
                    SASToken: Text;
                    BlobURL: Text;
                    BlobContent: Text;
                    StorageAccountName: Text;
                    ContainerName: Text;
                    BlobName: Text;
                    StorageEndpoint: Text;
                    AuthorizationHeader: Text;
                begin
                    // Provide your SAS Token and Blob URL
                    SASToken := 'st=2024-04-09T01:22:11Z&se=2050-12-31T09:22:11Z&si=test&sv=2022-11-02&sr=c&sig=7tBLLc0X518gadPNNP%2FEUXCRwCXWoaj%2FSQzu4oLcakI%3D';
                    BlobURL := 'https://your_storage_account.blob.core.windows.net/your_container/your_blob?your_sas_token';



                    BlobName := Rec."Blob Name";


                    StorageAccountName := 'edms';
                    ContainerName := 'edms-test';
                    SASToken := 'st=2024-04-09T01:22:11Z&se=2050-12-31T09:22:11Z&si=test&sv=2022-11-02&sr=c&sig=7tBLLc0X518gadPNNP%2FEUXCRwCXWoaj%2FSQzu4oLcakI%3D';
                    AuthorizationHeader := '?' + SASToken;

                    StorageEndpoint := 'https://' + StorageAccountName + '.blob.core.windows.net/' + ContainerName + '/' + BlobName + AuthorizationHeader;
                    BlobURL := StorageEndpoint;

                    BlobContent := BlobStorageHandler.GetBlobContent(SASToken, BlobURL);
                    Message('Blob Content: %1', BlobContent);
                end;
            }


            action(ShowLink)
            {
                Caption = 'Show Link';
                trigger OnAction()
                var
                    BlobStorageHandler: Codeunit "Azure Blob Storage Handler";
                    SASToken: Text;
                    BlobURL: Text;
                    BlobContent: Text;
                    StorageAccountName: Text;
                    ContainerName: Text;
                    BlobName: Text;
                    StorageEndpoint: Text;
                    AuthorizationHeader: Text;
                begin

                    Hyperlink(Rec."Blob Url");
                end;
            }
            action(InvalidateGuarantor)
            {
                Caption = 'Invalidate Guarantor';
                trigger OnAction()
                var
                    BlobStorageHandler: Codeunit "Azure Blob Storage Handler";
                    SASToken: Text;
                    BlobURL: Text;
                    BlobContent: Text;
                    StorageAccountName: Text;
                    ContainerName: Text;
                    BlobName: Text;
                    StorageEndpoint: Text;
                    AuthorizationHeader: Text;
                    PortalLoans: Record "Portal Loans";
                begin
                    If Confirm('Are you sure you want to remove this Guarantor?') then begin
                        Rec."Guarantor Accepted" := Rec."Guarantor Accepted"::Invalid;
                        Rec."Invalidated By" := UserId;
                        Rec.Modify();

                        PortalLoans.Get(Rec."Loan Entry No.");
                        PortalLoans.Status := PortalLoans.Status::"Pending Guarantor Action";
                        PortalLoans.Modify();

                    end;
                end;
            }


        }
    }
}
