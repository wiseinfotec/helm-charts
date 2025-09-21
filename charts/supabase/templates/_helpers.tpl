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
  {{- print .Values.external_db.host -}}
{{- end -}}
{{- end -}}

{{/*
Return the database port
*/}}
{{- define "supabase.database.port" -}}
{{- if .Values.db.enabled -}}
  {{- print .Values.db.service.port -}}
{{- else -}}
  {{- print .Values.external_db.port -}}
{{- end -}}
{{- end -}}

{{/*
Return the database sslmode
*/}}
{{- define "supabase.database.sslmode" -}}
{{- if .Values.db.enabled -}}
  {{- print "disable" -}}
{{- else -}}
  {{- print .Values.external_db.sslmode -}}
{{- end -}}
{{- end -}}

{{/*
The next variables are hardcoded in the supabase postgres db init scripts and migrations.
*/}}
{{- define "supabase.database.supabase_username" -}}
{{- if .Values.db.enabled -}}
  {{- print "supabase_admin" -}}
{{- else -}}
  {{- print .Values.external_db.username -}}
{{- end -}}
{{- end -}}

{{- define "supabase.database.storage_username" -}}
  {{- print "supabase_storage_admin" -}}
{{- end -}}

{{- define "supabase.database.rest_username" -}}
  {{- print "authenticator" -}}
{{- end -}}

{{- define "supabase.database.auth_username" -}}
  {{- print "supabase_auth_admin" -}}
{{- end -}}

{{- define "supabase.database.db_name" -}}
{{- if .Values.db.enabled -}}
  {{- print "postgres" -}}
{{- else -}}
  {{- print .Values.external_db.database -}}
{{- end -}}
{{- end -}}

{{- define "supabase.database.supabase_db_name" -}}
  {{- print "_supabase" -}}
{{- end -}}

{{- define "supabase.database.analytics_db_name" -}}
  {{- print "_analytics" -}}
{{- end -}}

{{- define "supabase.database.realtime_db_name" -}}
  {{- print "_realtime" -}}
{{- end -}}

{{/*
Return the database user password
*/}}
{{- define "supabase.database.password" -}}
{{- if .Values.db.enabled -}}
{{- if .Values.secret.db.secretRef -}}
valueFrom:
  secretKeyRef:
    name: {{ .Values.secret.db.secretRef }}
    key: {{ .Values.secret.db.secretRefKey.password }}
{{- else -}}
value: {{ .Values.secret.db.password | quote }}
{{- end -}}
{{- else -}}
{{- if .Values.external_db.secretRef -}}
valueFrom:
  secretKeyRef:
    name: {{ .Values.external_db.secretRef }}
    key: {{ .Values.external_db.secretRefKey.password }}
{{- else -}}
value: {{ .Values.external_db.password | quote }}
{{- end -}}
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
      value: {{ include "supabase.database.supabase_username" . | quote }}
{{- end -}}
