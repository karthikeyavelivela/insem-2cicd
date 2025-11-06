 {{- define "hms.name" -}}
 {{- .Chart.Name -}}
 {{- end -}}
 
 {{- define "hms.fullname" -}}
 {{- printf "%s-%s" .Release.Name (include "hms.name" .) | trunc 63 | trimSuffix "-" -}}
 {{- end -}}

