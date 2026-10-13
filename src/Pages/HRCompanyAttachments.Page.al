Page 51047 "HR Company Attachments"
{
    Caption = 'HR Company Attachments';
    PageType = List;
    SourceTable = "HR Company Attachments";

    layout
    {
        area(content)
        {
            repeater(Control1000000000)
            {
                field(DocumentDescription; Rec."Document Description")
                {
                    ApplicationArea = Basic;
                }
                field(Control1000000003; Rec.Attachment)
                {
                    ApplicationArea = Basic;
                }
            }
        }
    }

    actions
    {
        area(navigation)
        {
            group(Attachment)
            {
                Caption = '&Attachment';
                action(Open)
                {
                    ApplicationArea = Basic;
                    Caption = 'Open';

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, Rec."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink.Code, DocLink."Language Code (Default)", DocLink."Document Description") then
                                InteractTemplLanguage.OpenAttachment;
                        end;
                    end;
                }
                action(Create)
                {
                    ApplicationArea = Basic;
                    Caption = 'Create';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, Rec."Document Description") then begin
                            if not InteractTemplLanguage.Get(DocLink.Code, DocLink."Language Code (Default)", DocLink."Document Description") then begin
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
                action(Copyfrom)
                {
                    ApplicationArea = Basic;
                    Caption = 'Copy &from';
                    Ellipsis = true;
                    Visible = false;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, DocLink."Document Description") then begin

                            if InteractTemplLanguage.Get(DocLink.Code, DocLink."Language Code (Default)", DocLink."Document Description") then
                                InteractTemplLanguage.CopyFromAttachment;
                            CurrPage.Update;
                            //DocLink.Attachment:=DocLink.Attachment::Yes;
                            //DocLink.MODIFY;
                        end;
                    end;
                }
                action(Import)
                {
                    ApplicationArea = Basic;
                    Caption = 'Import';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, DocLink."Document Description") then begin
                            if not InteractTemplLanguage.Get(DocLink."Document Description", DocLink."Language Code (Default)") then begin
                                InteractTemplLanguage.Init;
                                InteractTemplLanguage."Interaction Template Code" := DocLink.Code;
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

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, DocLink."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink.Code, DocLink."Language Code (Default)", DocLink."Document Description") then
                                InteractTemplLanguage.ExportAttachment;
                        end;
                    end;
                }
                action(Remove)
                {
                    ApplicationArea = Basic;
                    Caption = 'Remove';
                    Ellipsis = true;

                    trigger OnAction()
                    var
                        InteractTemplLanguage: Record "Interaction Tmpl. Language";
                    begin
                        if DocLink.Get(DocLink.Code, DocLink."Document Description") then begin
                            if InteractTemplLanguage.Get(DocLink.Code, DocLink."Language Code (Default)", DocLink."Document Description") then begin
                                InteractTemplLanguage.RemoveAttachment(true);
                                DocLink.Attachment := DocLink.Attachment::No;
                                DocLink.Modify;
                            end;
                        end;
                    end;
                }
            }
        }
    }

    var
        InteractTemplLanguage: Record "Interaction Tmpl. Language";
        DocLink: Record "HR Company Attachments";


    procedure GetDocument() Document: Text[200]
    begin
        Document := DocLink."Document Description";
    end;
}

