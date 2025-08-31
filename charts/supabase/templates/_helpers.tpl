{{/*
Expand the name of the chart.
*/}}
{{- define "supabase.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "supabase.fullname" -}}
{{- if .Values.fullnameOverride }}
{{- .Values.fullnameOverride | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- $name := default .Chart.Name .Values.nameOverride }}
{{- if contains $name .Release.Name }}
{{- .Release.Name | trunc 63 | trimSuffix "-" }}
{{- else }}
{{- printf "%s-%s" .Release.Name $name | trunc 63 | trimSuffix "-" }}
{{- end }}
{{- end }}
{{- end }}

{{/*
Create chart name and version as used by the chart label.
*/}}
{{- define "supabase.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "supabase.labels" -}}
helm.sh/chart: {{ include "supabase.chart" . }}
{{ include "supabase.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "supabase.selectorLabels" -}}
app.kubernetes.io/name: {{ include "supabase.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "supabase.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "supabase.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Return the database host
*/}}
{{- define "supabase.database.host" -}}
{{- if .Values.db.enabled -}}
  {{- print (include "supabase.db.fullname" .) -}}
{{- else -}}
  {{- print .Values.secret.db.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the database port
*/}}
{{- define "supabase.database.port" -}}
{{- if .Values.db.enabled -}}
  {{- print .Values.db.service.port -}}
{{- else -}}
  {{- print .Values.secret.db.port  -}}
{{- end -}}
{{- end -}}

{{/*
Return the database sslmode
*/}}
{{- define "supabase.database.sslmode" -}}
{{- if .Values.db.enabled -}}
  {{- print "disable" -}}
{{- else -}}
  {{- print .Values.secret.db.sslmode -}}
{{- end -}}
{{- end -}}

{{/*
Return the database name
*/}}
{{- define "supabase.database.name" -}}
{{- if .Values.db.enabled -}}
  {{/* The 'postgres' is hardcoded in the supabase/postgres container */}}
  {{- print "postgres" -}}
{{- else -}}
  {{- print .Values.secret.db.database -}}
{{- end -}}
{{- end -}}

{{/*
Return the database username
*/}}
{{- define "supabase.database.username" -}}
{{- if .Values.db.enabled -}}
  {{/* The 'supabase_admin' is hardcoded in the supabase/postgres container */}}
  {{- print "supabase_admin" -}}
{{- else -}}
  {{- if .Values.secret.secretRef -}}
    {{- print .Values.secret.secretRefKey.username -}}
  {{- else -}}
    {{- print .Values.secret.db.username -}}
  {{- end -}}
{{- end -}}
{{- end -}}

{{/*
Return the database user password
*/}}
{{- define "supabase.database.password" -}}
{{- if .Values.secret.secretRef -}}
  {{- print .Values.secret.secretRefKey.password -}}
{{- else -}}
  {{- print .Values.secret.db.password -}}
{{- end -}}
{{- end -}}

{{- define "supabase.waitForDB" -}}
- name: wait-for-db
  image: {{ .Values.init_db.image.repository }}:{{ .Values.init_db.image.tag }}
  imagePullPolicy: {{ .Values.init_db.image.pullPolicy }}
  securityContext:
  {{- toYaml .Values.init_db.podSecurityContext | nindent 4 }}
  command:
    - bash
    - -ec
    - |
      until pg_isready -h $(DB_HOST) -p $(DB_PORT) -U $(DB_USER); do
      echo "Waiting for database to start..."
      sleep 2
      done
    - echo "Database is ready"
  env:
    - name: DB_HOST
      value: {{ include "supabase.database.host" . | quote }}
    - name: DB_PORT
      value: {{ include "supabase.database.port" . | quote }}
    - name: DB_USER
      values: {{ include "supabase.database.username" . | quote }}
{{- end -}}
