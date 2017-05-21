function Get-FontName
{
<#
.SYNOPSIS
    Retrieves the font name from a TTF file.

.DESCRIPTION
    This cmdlet does not install a font. It retrieves the font name from the given file, or the provided path

.PARAMETER Path
    Specifies the path to the font files


.PARAMETER Item
    Specifies the file item object. This is provided by Get-Item or Get-ChildItem.

.EXAMPLE 
    Get-FontName -Path $myfontPath

.EXAMPLE 
    Get-ChildItem -Path *.ttf | Get-FontName

.NOTES
    Micky Balladelli
#>
    [CmdletBinding()]
    PARAM(
        [Parameter(
            ParameterSetName='Path'
        )]
        [String]$Path,
 
        [Parameter(
            ValueFromPipeline = $true,
            ParameterSetName='Item'
        )]
        [object[]]$Item

    )

    BEGIN
    {
        Add-Type -AssemblyName System.Drawing
        $ttfFiles = @()
        $fontCollection = new-object System.Drawing.Text.PrivateFontCollection
    }
    
    PROCESS
    {
        if ($Path -ne "")
        {
            $ttfFiles = Get-ChildItem $path
        }
        else
        {
            $ttfFiles += $Item
        }

    }

    END
    {
        $ttfFiles | ForEach-Object {
            $fontCollection.AddFontFile($_.fullname)
            $fontCollection.Families[-1].Name
        }
    }
}