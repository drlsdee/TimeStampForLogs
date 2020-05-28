function New-TimeStamp {
    [CmdletBinding()]
    param (
        [Parameter()]
        # Datetime format string; e.g. 'yyyy-MM-dd HH:mm:ss.fff' will show date and time like a string '2020-05-22 15:41:01.123'; default is RFC 3389 / ISO 8601 string
        [string]
        $Format = 'yyyy-MM-dd HH:mm:ss.fff',

        [Parameter()]
        # Description, e.g. function name
        [string]
        $Description,

        [Parameter()]
        # By default datetime is a string in RFC 3389 / ISO 8601 format; is switch is set, returns local datetime
        [switch]
        $NoUTC,

        [Parameter()]
        # If not set, timestamp and description strings will be printed in square brackets and log message will looks like this: "VERBOSE: [2020-05-22 15:41:01.123]: [New-TimeStamp]: Starting function..."
        [switch]
        $NoBrackets
    )

    if ($NoUTC) {
        $methodString = "DateTime"
    } else {
        $Format = 'yyyy-MM-ddTHH:mm:ss.fffffffzzzK'
        $methodString = "UtcDateTime"
    }

    if ($NoBrackets -and (-not $Description.Length)) {
        "$([System.DateTimeOffset]::Now.$methodString.ToString($Format))"
    } elseif ($NoBrackets) {
        "$([System.DateTimeOffset]::Now.$methodString.ToString($Format)): $($Description):"
    } elseif (-not $Description.Length) {
        "[$([System.DateTimeOffset]::Now.$methodString.ToString($Format))]:"
    } else {
        "[$([System.DateTimeOffset]::Now.$methodString.ToString($Format))]: [$($Description)]:"
    }
}