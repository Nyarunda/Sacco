/*
Page 51126 "HR Interns Card"
{
    PageType = Card;
    SourceTable = UnknownEmployee;

    layout
    {
        area(content)
        {
            group(General)
            {
                field(FullName; "Full Name")
                {
                    ApplicationArea = Basic;
                }
                field(Sex; Sex)
                {
                    ApplicationArea = Basic;
                }
                field(Ethnicity; Ethnicity)
                {
                    ApplicationArea = Basic;
                }
                field(Institution; Institution)
                {
                    ApplicationArea = Basic;
                }
                field(MonthlyStipend; "Monthly Stipend")
                {
                    ApplicationArea = Basic;
                }
                group(Control25)
                {
                    grid(Control24)
                    {
                        GridLayout = Rows;
                        group(Control23)
                        {
                            field(CourseUndertaken; "Course Undertaken")
                            {
                                ApplicationArea = Basic;
                            }
                            field(Specialization; Specialization)
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                }
                group(Control21)
                {
                    grid(Postedto)
                    {
                        Caption = 'Posted to';
                        GridLayout = Rows;
                        group(Control13)
                        {
                            field(GlobalDimension1Code; "Global Dimension 1 Code")
                            {
                                ApplicationArea = Basic;
                            }
                            field(GlobalDimension2Code; "Global Dimension 2 Code")
                            {
                                ApplicationArea = Basic;
                            }
                        }
                    }
                    group(Control19)
                    {
                        grid(PostedPeriod)
                        {
                            Caption = 'Posted Period';
                            GridLayout = Rows;
                            group(Control17)
                            {
                                field(PostedQuarter; "Posted Quarter")
                                {
                                    ApplicationArea = Basic;
                                }
                                field(PeriodStart; "Period Start")
                                {
                                    ApplicationArea = Basic;
                                }
                                field(PeriodEnd; "Period End")
                                {
                                    ApplicationArea = Basic;
                                }
                                field(PostingStatus; "Posting Status")
                                {
                                    ApplicationArea = Basic;
                                    Editable = false;
                                    StyleExpr = StyleText;
                                }
                            }
                        }
                    }
                }
            }
        }
        area(factboxes)
        {
            systempart(Control16; Notes)
            {
            }
        }
    }

    actions
    {
    }

    trigger OnAfterGetRecord()
    begin
        //StyleText:=HRCodeunit.fn_SetStyle(FORMAT("Posting Status"));
    end;

    var
        StyleText: Text;
        HRCodeunit: Codeunit "HR Codeunit.";
}

*/