{{/*
Expand the name of the JWT secret.
*/}}
{{- define "supabase.secret.jwt" -}}
{{- printf "%s-jwt" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the pooler secret.
*/}}
{{- define "supabase.secret.pooler" -}}
{{- printf "%s-pooler" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the SMTP secret.
*/}}
{{- define "supabase.secret.smtp" -}}
{{- printf "%s-smtp" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the dashboard secret.
*/}}
{{- define "supabase.secret.dashboard" -}}
{{- printf "%s-dashboard" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the database secret.
*/}}
{{- define "supabase.secret.db" -}}
{{- printf "%s-db" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the analytics secret.
*/}}
{{- define "supabase.secret.analytics" -}}
{{- printf "%s-analytics" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Expand the name of the s3 secret.
*/}}
{{- define "supabase.secret.s3" -}}
{{- printf "%s-s3" (include "supabase.fullname" .) }}
{{- end -}}

{{/*
Check if both s3 keys are valid
*/}}
{{- define "supabase.secret.s3.isValid" -}}
{{- $isValid := "false" -}}
{{- if .Values.secret.s3.keyId -}}
{{- if .Values.secret.s3.accessKey -}}
{{- printf "true" -}}
{{- else -}}
{{- printf "false" -}}
{{- end -}}
{{- else -}}
{{- printf "false" -}}
{{- end -}}
{{- end -}}

{{/*
Expand the name of the realtime secret.
*/}}
{{- define "supabase.secret.realtime" -}}
{{- printf "%s-realtime" (include "supabase.fullname" .) }}
{{- end -}}
