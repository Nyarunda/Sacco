
PageExtension 50119 pageextension50119 extends "Depreciation Book Card"
{
    layout
    {
        addafter("Fiscal Year 365 Days")
        {
            field("Use Customized Depr. Amount"; Rec."Use Customized Depr. Amount")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

