# Build the manager binary
FROM --platform=${BUILDPLATFORM:-linux/amd64} golang:1.21@sha256:4746d26432a9117a5f58e95cb9f954ddf0de128e9d5816886514199316e4a2fb as builder

ARG BUILDPLATFORM
ARG TARGETPLATFORM
ARG TARGETOS
ARG TARGETARCH
RUN echo "BUILDPLATFORM: ${BUILDPLATFORM}, TARGETPLATFORM: ${TARGETPLATFORM}, TARGETOS: ${TARGETOS}, TARGETARCH: ${TARGETARCH}"

WORKDIR /workspace
# Copy the Go Modules manifests
COPY go.mod go.mod
COPY go.sum go.sum
# cache deps before building and copying source so that we don't need to re-download as much
# and so that source changes don't invalidate our downloaded layer
COPY api api
COPY properties properties
RUN go mod download

# Copy the go source
COPY main.go main.go
COPY controllers/ controllers/
COPY internal/ internal/
COPY pkg/ pkg/

# Build
RUN CGO_ENABLED=0 GOOS=${TARGETOS:-linux} GOARCH=${TARGETARCH:-amd64} GO111MODULE=on go build -a -o manager main.go

# Use distroless as minimal base image to package the manager binary
# Refer to https://github.com/GoogleContainerTools/distroless for more details
FROM --platform=${TARGETPLATFORM:-linux/amd64} gcr.io/distroless/static-debian11:nonroot@sha256:63ebe035fbdd056ed682e6a87b286d07d3f05f12cb46f26b2b44fc10fc4a59ed
WORKDIR /
COPY --from=builder /workspace/manager .
ENTRYPOINT ["/manager"]
