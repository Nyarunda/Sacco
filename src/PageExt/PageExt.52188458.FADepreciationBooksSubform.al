
PageExtension 50121 pageextension50121 extends "FA Depreciation Books Subform"
{
    layout
    {
        addafter("Straight-Line %")
        {
            field("Customized Depr. Amount"; Rec."Customized Depr. Amount")
            {
                ApplicationArea = Basic;
            }
            field("FA Add.-Currency Factor"; Rec."FA Add.-Currency Factor")
            {
                ApplicationArea = Basic;
            }
        }
    }
}

