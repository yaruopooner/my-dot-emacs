Param( $vsVersion, $mArch, $msbTargetFile, $msbFlags, $logFile )


# mArch : machine architecture x86, amd64, x64(amd64), ia64, x86_amd64, x86_ia64

$Host.UI.RawUI.BufferSize = New-Object Management.Automation.Host.Size (4096, 1024)


# $command2 = [System.IO.Path]::Combine( $env:SYSTEMROOT, "system32\cmd.exe" )


function Get-VsCommonToolsPath( $vsVersion )
{
    # "$vsVersion"

    switch ( $vsVersion )
    {
        2008 { $vsPath = $env:VS90COMNTOOLS }
        2010 { $vsPath = $env:VS100COMNTOOLS }
        2012 { $vsPath = $env:VS110COMNTOOLS }
        default { return $null }
    }

    # "$vsPath"

    if ( $vsPath -ne $null )
    {
        # return (Get-ChildItem $vsPath).Value
        return $vsPath
    }
    else
    {
        return $null
    }
}

function Get-VcVarsBatchFile( $vsVersion )
{
    $vsToolsPath = Get-VsCommonToolsPath -vsVersion $vsVersion

    # "$vsVersion"
    # "$vsToolsPath"

    if ( $vsToolsPath -ne $null )
    {
        return [System.IO.Path]::Combine($vsToolsPath, "..\..\VC\vcvarsall.bat")
    }
    else
    {
        return $null
    }
}

function Set-VcVars( $vsVersion, $mArch )
{
    # $env:SYSTEMROOT
    $batchFile = Get-VcVarsBatchFile -vsVersion $vsVersion
    # $env:SYSTEMROOT

    if ( ($batchFile -eq $null) -or ($mArch -eq $null) )
    {
        return $false
    }

    # $path = $env:SYSTEMROOT
    # $command = "${env:SystemRoot}/system32/cmd.exe"
    $command = [System.IO.Path]::Combine( $env:SYSTEMROOT, "system32\cmd.exe" )

    # $fullcommand = "$command /C `"$batchFile`" $mArch & SET"
    # $result = Invoke-Expression -Command $fullcommand

    $execCommand = "`"$batchFile`" $mArch & SET"
    # CMD /C $execCommand | Foreach-Object {
    # c:/windows/system32/cmd.exe /C $execCommand | Foreach-Object {
    # $env:SystemRoot/system32/cmd.exe /C $execCommand | Foreach-Object {
    &$command /C $execCommand | Foreach-Object {
    # Invoke-Expression -Command $fullcommand | Foreach-Object {
    # &$fullcommand | Foreach-Object {
        $property, $value = $_.split( '=' )
        Set-Item -path env:$property -value $value
    }

    # "command = $command"
    return $true
}

function Exec-MSBuild( $vsVersion, $mArch, $msbTargetFile, $msbFlags, $logFile )
{
    # $command2
    # get-childitem env:
    # "env = $env:"
    "vsVersion = $vsVersion"
    "mArch = $mArch"
    "msbTargetFile = $msbTargetFile"
    "msbFlags = $msbFlags"
    "logFile = $logFile"

    if ( -not ( Set-VcVars -vsVersion $vsVersion -mArch $mArch ) )
    {
        return $false
    }

    "system root = $env:SYSTEMROOT"

    # "env = "
    # Get-ChildItem Env:

    # $packageDirectory = [System.IO.Path]::GetDirectoryName( $script:MyInvocation.MyCommand.Path )
    # CD $packageDirectory
    Set-Location ( Split-Path $script:MyInvocation.MyCommand.Path -parent )

    # pwd

    # $words = -split $msbFlags

    # for ( $i = 0; $i -lt $words.length; $i++ )
    # {
    #   $words2[ $i ] = "`"$words[ $i ]`""
    # }

    # foreach ( $v in $words2 )
    # {
    #   "v = $v"
    # }
    # -split $msbFlags


    # $fullcommand = "MSBUILD $msbTargetFile $msbFlags"
    # $fullcommand = "MSBUILD `"$msbTargetFile`" $msbFlags > hoge"
    # $result = Invoke-Expression -Command $fullcommand
    

    # $result = $exe $params
    $result = Start-Process MSBUILD -ArgumentList $msbTargetFile, $msbFlags -Wait -NoNewWindow

    # $result = Start-Job MSBUILD -ArgumentList $msbTargetFile, $msbFlags

    # $result = MSBUILD $msbTargetFile "`"$msbFlags`"" > hoge
    # $result = MSBUILD $msbTargetFile "/p:ImportProjectFile=d:/develop_env/engine_pg20130621/engine_pg/anzu/projects/vs2010/windows/engine.vcxproj;Platform=x64;Configuration=Release;CompileFile=empty.cpp;IntDir=c:/cygwin20121103/root/.emacs.d/msvc-db/!drive_d!develop_env!engine_pg20130621!engine_pg!anzu!projects!vs2010!windows!engine!x64!Release/;OutDir=c:/cygwin20121103/root/.emacs.d/msvc-db/!drive_d!develop_env!engine_pg20130621!engine_pg!anzu!projects!vs2010!windows!engine!x64!Release/ /flp:Verbosity=normal;LogFile=c:/cygwin20121103/root/.emacs.d/msvc-db/!drive_d!develop_env!engine_pg20130621!engine_pg!anzu!projects!vs2010!windows!engine!x64!Release/cflags.log;Encoding=UTF-8 /flp1:Verbosity=diagnostic;LogFile=c:/cygwin20121103/root/.emacs.d/msvc-db/!drive_d!develop_env!engine_pg20130621!engine_pg!anzu!projects!vs2010!windows!engine!x64!Release/cflags-diagnostic.log;Encoding=UTF-8 /noconsolelogger /nologo" > hoge
    # "result = $result"

    if ( -not ( Test-Path $logFile ) )
    {
        # return $false
        exit 1
    }

    CAT $logFile

    # return $true
    exit 0
}



Exec-MSBuild -vsVersion $vsVersion -mArch $mArch -msbTargetFile $msbTargetFile -msbFlags $msbFlags -logFile $logFile


