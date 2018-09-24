function Search-in-google 
{
    param([string[]] $Query)

    Add-Type -AssemblyName System.Web # To get UrlEncode()
    $QueryString = ($Query | %{ [Web.HttpUtility]::UrlEncode($_)}) -join '+'

    # Return the query string
    $QueryString
}
clear
$SearchString = Read-Host -Prompt 'Introduce cadena de busqueda'

#$SearchString = "mantenimiento informatico"
$numero = Read-Host -Prompt 'Introduce numero de resultados entre 1 y 99'
$QueryString = Search-in-google $SearchString
$url = "https://www.google.es/search?num=$numero&q=$SearchString"
$lista_google = Invoke-WebRequest -uri $url
$extract_site = ($lista_google.AllElements | Where {$_.innerhtml -like '*=*'} | Where {$_.class -eq 's'}).innerText 
$regex = ‘([a-zA-Z]{3,})://([\w-]+\.)+[\w-]+(/[\w- ./?%&=]*)*?’
$lst_site = $extract_site | select-string -Pattern $regex -AllMatches | % { $_.Matches } | % { $_.Value }
$posicion = 0
foreach ($item in $lst_site) {
$posicion = $posicion + 1

   $timeTaken = Measure-Command -Expression {
    $site = Invoke-WebRequest -uri $item 
    }
$millisegundos = $timeTaken.TotalMilliseconds

$segundos = [Math]::Round($millisegundos/1000, 1)

echo "$item esta en la posicion $posicion en google y el timpo de carga es $segundos segundos"

"La carga de la página se ha realizado en  $segundos segundos"::NewLine

}