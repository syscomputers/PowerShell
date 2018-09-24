###############################################################################
#######               Script https://www.madridinformatico.es           #######
#######                          versión 1.0                            #######
#######                           13.09.2018                            #######
#######                  email:info@madridinformatico.es                #######
#######         Mide el tiempo de carga de un sitio web                 #######
###############################################################################

[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
$Uri = Read-Host -Prompt 'Introduce la dirección web'

$timeTaken = Measure-Command -Expression {
$site = Invoke-WebRequest -uri $URI 
}

$millisegundos = $timeTaken.TotalMilliseconds

$segundos = [Math]::Round($millisegundos/1000, 1)

"La carga de la página se ha realizado en  $segundos segundos"

