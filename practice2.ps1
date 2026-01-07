# hashtable practice2
$ht1 = @{name="John","Joe","Mary";DaysWorked=12,20,18}
$ht2 = @{name=$ht1.name[0],$ht1.name[1],$ht1.name[2];SalaryPerDay=100,120,150}

$JohnSalary = $ht1.DaysWorked[0] * $ht2.SalaryPerDay[0]
$JoeSalary = $ht1.DaysWorked[1] * $ht2.SalaryPerDay[1]
$MarySalary = $ht1.DaysWorked[2] * $ht2.SalaryPerDay[2]

$ht3 = @{name=$ht1.name[0],$ht1.name[1],$ht1.name[2];Salary=$JohnSalary,$JoeSalary,$MarySalary}
$ht3