{{/*
Expand the name of the chart.
*/}}
{{- define "bitnode.name" -}}
{{- default .Chart.Name .Values.nameOverride | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Create a default fully qualified app name.
We truncate at 63 chars because some Kubernetes name fields are limited to this (by the DNS naming spec).
If release name contains chart name it will be used as a full name.
*/}}
{{- define "bitnode.fullname" -}}
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
{{- define "bitnode.chart" -}}
{{- printf "%s-%s" .Chart.Name .Chart.Version | replace "+" "_" | trunc 63 | trimSuffix "-" }}
{{- end }}

{{/*
Common labels
*/}}
{{- define "bitnode.labels" -}}
helm.sh/chart: {{ include "bitnode.chart" . }}
{{ include "bitnode.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bitnode.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitnode.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}

{{/*
Create the name of the service account to use
*/}}
{{- define "bitnode.serviceAccountName" -}}
{{- if .Values.serviceAccount.create }}
{{- default (include "bitnode.fullname" .) .Values.serviceAccount.name }}
{{- else }}
{{- default "default" .Values.serviceAccount.name }}
{{- end }}
{{- end }}

{{/*
Generate config file
*/}}
{{- define "config" -}}
{{ toYaml .Values.conf | indent 2 }}
{{- end }}

{{/*
Common btc exploerer labels
*/}}
{{- define "bre.labels" -}}
helm.sh/chart: {{ include "bitnode.chart" . }}
app: "explorer"
{{ include "bitnode.selectorLabels" . }}
{{- if .Chart.AppVersion }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
{{- end }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Selector labels
*/}}
{{- define "bre.selectorLabels" -}}
app.kubernetes.io/name: {{ include "bitnode.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app: "explorer"
{{- end }}

{{- define "p2pPort" }}
{{- if .Values.regtest }}18334
{{- else if .Values.testnet }}18334
{{- else }}8333{{- end }}
{{- end }}

{{- define "rpcPort" }}
{{- if .Values.regtest }}18444
{{- else if .Values.testnet }}18333
{{- else }}8334
{{- end }}
{{- end }}