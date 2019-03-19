
$external = "$PSScriptRoot\app\.externalNativeBuild"
$target = "$PSScriptRoot\output"

('arm64-v8a', 'armeabi-v7a') | % { 
    md "$target\$_" -force
    cp "$external\cmake\release\$_\opencv\lib\$_\*"          "$target\$_" -Verbose -Force
    cp "$external\cmake\release\$_\opencv\3rdparty\lib\$_\*" "$target\$_" -Verbose -Force
}
