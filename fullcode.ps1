Clear-Host
<#

remove all file that has ADAPTER in file name

#>
$pattern1 = "ADAPTER"
$path = "userPathIB"
Get-ChildItem $path -Recurse | Where{$_.Name -match $pattern1} | Remove-Item|Out-Null
<#

convert all file with file extensin catpart and catproduct to ddd format

#>
$InPath="modelifile"
$OutPath="newfile"
$Command="converter"
$files= Get-ChildItem $InPath -recurse -force
ForEach($file in $files){
if($file.Extension -eq ".CATPart" -and ".CATProduct" ){
Write-Host $file.FullName
&$Command $file.FullName -s -ddd "-q:custom" |Out-Null
}
}
<#

copy all converted ddd files to new file

#>
Copy-Item -Filter *.ddd $InPath -Recurse -Destination $OutPath |Out-Null

<#

adding time and date to file name so a dont need to make a new folder every time after converting

#>
$filenameFormat = "convertedparts" + " " + (Get-Date -Format yyy-mm-dd-hhmm)
Rename-Item -Path $OutPath -NewName $filenameFormat |Out-Null
<#

remove all files from the inPath

#>
Remove-Item "newFile*.*"