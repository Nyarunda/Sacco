namespace UnitedWomen.UnitedWomen;

using System.Text;
using System.Utilities;

page 50896 "Member Images API"
{
    PageType = API;
    APIPublisher = 'calwide';
    APIGroup = 'members';
    APIVersion = 'v1.0';

    EntityName = 'memberImage';
    EntitySetName = 'memberImages';

    SourceTable = "Member Images";
    DelayedInsert = true;
    ODataKeyFields = SystemId;

    InsertAllowed = true;
    ModifyAllowed = false;
    DeleteAllowed = false;

    layout
    {
        area(content)
        {
            repeater(Group)
            {
                field(systemId; Rec.SystemId)
                {
                    Editable = false;
                }

                field(memberNo; Rec."Member No.")
                {
                    Caption = 'Old Member No.';
                }

                field(pictureBase64; PictureBase64Txt)
                {
                    trigger OnValidate()
                    begin
                        SaveBase64ToBlob(PictureBase64Txt, 'PICTURE');
                    end;
                }

                field(signatureBase64; SignatureBase64Txt)
                {
                    trigger OnValidate()
                    begin
                        SaveBase64ToBlob(SignatureBase64Txt, 'SIGNATURE');
                    end;
                }
            }
        }
    }

    trigger OnInsertRecord(BelowxRec: Boolean): Boolean
    var
        OldMemberNo: Code[20];
    begin
        Rec.TestField("Member No.");

        OldMemberNo := Rec."Member No.";

        Rec."Member No." := GetNewMemberNoFromOldMemberNo(OldMemberNo);

        if InsertOrUpdateMemberImage() then
            exit(false);

        exit(true);
    end;

    var
        PictureBase64Txt: Text;
        SignatureBase64Txt: Text;

    local procedure GetNewMemberNoFromOldMemberNo(OldMemberNo: Code[20]): Code[20]
    var
        Member: Record Members;
    begin
        if OldMemberNo = '' then
            Error('Old Member No. cannot be blank.');

        Member.Reset();

        // Change "Old Member No." below to the actual field name in your Members table.
        Member.SetRange("Old Member No.", OldMemberNo);

        if Member.FindFirst() then
            exit(Member."No.");

        // Optional fallback: if the old member no is already same as new member no.
        if Member.Get(OldMemberNo) then
            exit(Member."No.");

    
    end;

    local procedure InsertOrUpdateMemberImage(): Boolean
    var
        ExistingMemberImage: Record "Member Images";
    begin
        ExistingMemberImage.Reset();
        ExistingMemberImage.SetRange("Member No.", Rec."Member No.");

        if not ExistingMemberImage.FindFirst() then
            exit(false);

        CopyBlobFields(ExistingMemberImage);

        ExistingMemberImage.Modify();
        exit(true);
    end;

    local procedure CopyBlobFields(var ExistingMemberImage: Record "Member Images")
    var
        FromInStream: InStream;
        ToOutStream: OutStream;
    begin
        if PictureBase64Txt <> '' then begin
            Rec.CalcFields(Picture);
            Rec.Picture.CreateInStream(FromInStream);
            ExistingMemberImage.Picture.CreateOutStream(ToOutStream);
            CopyStream(ToOutStream, FromInStream);
        end;

        if SignatureBase64Txt <> '' then begin
            Rec.CalcFields(Signature);
            Rec.Signature.CreateInStream(FromInStream);
            ExistingMemberImage.Signature.CreateOutStream(ToOutStream);
            CopyStream(ToOutStream, FromInStream);
        end;
    end;

    local procedure SaveBase64ToBlob(Base64Text: Text; ImageType: Text)
    var
        Base64Convert: Codeunit "Base64 Convert";
        TempBlob: Codeunit "Temp Blob";
        TempOutStream: OutStream;
        TempInStream: InStream;
        TargetOutStream: OutStream;
    begin
        if Base64Text = '' then
            exit;

        TempBlob.CreateOutStream(TempOutStream);
        Base64Convert.FromBase64(Base64Text, TempOutStream);

        TempBlob.CreateInStream(TempInStream);

        case ImageType of
            'PICTURE':
                begin
                    Rec.Picture.CreateOutStream(TargetOutStream);
                    CopyStream(TargetOutStream, TempInStream);
                end;

            'SIGNATURE':
                begin
                    Rec.Signature.CreateOutStream(TargetOutStream);
                    CopyStream(TargetOutStream, TempInStream);
                end;
        end;
    end;
}