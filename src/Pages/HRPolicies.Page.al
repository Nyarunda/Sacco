Page 51046 "HR Policies"
{
    PageType = Document;
    SourceTable = "HR Policies";

    layout
    {
        area(content)
        {
            group(General)
            {
                field("Code"; Rec.Code)
                {
                    ApplicationArea = Basic;
                }
                field(DocumentDescription; Rec."Document Description")
                {
                    ApplicationArea = Basic;
                }
                field(Date; Rec.Date)
                {
                    ApplicationArea = Basic;
                }
                field(Type; Rec.Type)
                {
                    ApplicationArea = Basic;
                }
                field(RulesRegulations; Rec."Rules & Regulations")
                {
                    ApplicationArea = Basic;
                    MultiLine = true;
                }
                field(Remarks; Rec.Remarks)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(processing)
        {
            action(Open)
            {
                ApplicationArea = Basic;
                Caption = 'Open';
                Image = Open;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //IF InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            InteractTemplLanguage.OpenAttachment;
                    end;
                end;
            }
            action(Create)
            {
                ApplicationArea = Basic;
                Caption = 'Create';
                Ellipsis = true;
                //Image = Create_Movement;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if not InteractTemplLanguage.FindFirst then
                        //iF NOT InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN
                        begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec.Code;
                            InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                            InteractTemplLanguage.Description := Rec."Document Description";
                        end;
                        InteractTemplLanguage.CreateAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action(CopyFrom)
            {
                ApplicationArea = Basic;
                Caption = 'Copy & From';
                Ellipsis = true;
                Image = Copy;
                Promoted = true;
                PromotedCategory = Category4;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //IF InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN

                            InteractTemplLanguage.CopyFromAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action(Import)
            {
                ApplicationArea = Basic;
                Caption = 'Import';
                Ellipsis = true;
                Image = Import;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if not InteractTemplLanguage.FindFirst then
                        //IF NOT InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN
                        begin
                            InteractTemplLanguage.Init;
                            InteractTemplLanguage."Interaction Template Code" := Rec.Code;
                            InteractTemplLanguage."Language Code" := DocLink."Language Code (Default)";
                            InteractTemplLanguage.Description := DocLink."Document Description";
                            InteractTemplLanguage.Insert;
                        end;
                        InteractTemplLanguage.ImportAttachment;
                        CurrPage.Update;
                        DocLink.Attachment := DocLink.Attachment::Yes;
                        DocLink.Modify;
                    end;
                end;
            }
            action(Export)
            {
                ApplicationArea = Basic;
                Caption = 'E&xport';
                Ellipsis = true;
                Image = Export;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then
                            //iF InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN
                            InteractTemplLanguage.ExportAttachment;
                    end;
                end;
            }
            action(Remove)
            {
                ApplicationArea = Basic;
                Caption = 'Remove';
                Ellipsis = true;
                Image = RemoveContacts;
                Promoted = true;
                PromotedCategory = Category4;
                PromotedIsBig = true;
                Visible = false;

                trigger OnAction()
                var
                    InteractTemplLanguage: Record "Interaction Tmpl. Language";
                begin
                    if DocLink.Get(Rec.Code) then begin
                        InteractTemplLanguage.Reset;
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Interaction Template Code", Rec.Code);
                        InteractTemplLanguage.SetRange(InteractTemplLanguage."Language Code", DocLink."Language Code (Default)");
                        InteractTemplLanguage.SetRange(InteractTemplLanguage.Description, DocLink."Document Description");
                        if InteractTemplLanguage.FindFirst then begin
                            //IF InteractTemplLanguage.GET(DocLink.code,DocLink."Language Code (Default)",DocLink."Document Description") THEN BEGIN
                            InteractTemplLanguage.RemoveAttachment(true);
                            DocLink.Attachment := DocLink.Attachment::No;
                            DocLink.Modify;
                        end;
                    end;
                end;
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "HR Company Attachments";
}

