$logfile = "C:\Users\hzsis-LiuYiWei\Desktop\1.txt"

Search-ADAccount -LockedOut | fl DistinguishedName,SamAccountName > $logfile

#get-aduser -filter * -properties * | where {$_.lockedout} | ft name,lockedout > $logfile

#$nMsg = cat "$logfile"
#echo $nMsg
$date = get-date 
$nSmtpserver = "192.50.6.248"
$nFrom = "Login_Monitor@gpe-hkg.com"
$nTo = "y.w.liu@gpe-hkg.com","edmond.lee@gpe-hkg.com","x.m.zou@gpe-hkg.com","n.w.he@gpe-hkg.com","m.cao@gpe-hkg.com","c.q.chen@gpe-hkg.com","kenji.wong@gpe-hkg.com","ray.kong@gpe-hkg.com","w.n.meng@gpe-hkg.com","settaphon.ear@gpet.co.th"
$nSubject = "Note: The following users have just been locked "



$line3=(Get-Content $logfile -totalcount 3)[-1]
$line4=(Get-Content $logfile -totalcount 4)[-1]
$line5=(Get-Content $logfile -totalcount 5)[-1]
$line6=(Get-Content $logfile -totalcount 6)[-1]
$line7=(Get-Content $logfile -totalcount 7)[-1]
$line8=(Get-Content $logfile -totalcount 8)[-1]
$line9=(Get-Content $logfile -totalcount 9)[-1]
$line10=(Get-Content $logfile -totalcount 10)[-1]
$line11=(Get-Content $logfile -totalcount 11)[-1]

echo $name1
#(Get-Content $logfile -totalcount 4)[-1]


$mailtext = @"
Dear Administrator,
<br>
</br>
<br> <font color="red"> &emsp;&emsp; #This is a system email, please don't reply.# </font> </br>
<br> &emsp;&emsp; Please pay attention.The following users have been locked.</br>
<br>
</br>
<br> &emsp;&emsp; $line3 </br>
<br> &emsp;&emsp; $line4 </br>
<br> &emsp;&emsp; $line5 </br>
<br> &emsp;&emsp; $line6 </br>
<br> &emsp;&emsp; $line7 </br>
<br> &emsp;&emsp; $line8 </br>
<br> &emsp;&emsp; $line9 </br>
<br> &emsp;&emsp; $line10 </br>
<br> &emsp;&emsp; $line11 </br>
<br>
</br>
"@
$mailbody = $head + $mailtext +$mailtable

$result = [String]::IsNullOrWhiteSpace((Get-content $logfile))
#echo $result
if(!$result)

{ 
    #send-mailmessage -BodyAsHtml -subject $nSubject -Smtpserver $nSmtpserver -From $nFrom -To $nTo -body ($nMsg | Out-String) #-Encoding ([System.Text.Encoding]::UTF8)
    send-mailmessage -BodyAsHtml -subject $nSubject -Smtpserver $nSmtpserver -From $nFrom -To $nTo -Body $mailbody -Encoding ([System.Text.Encoding]::UTF8)

}
