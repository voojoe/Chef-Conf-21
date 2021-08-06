# Build controls profile
FROM chef/inspec:4.29.3 AS build
ENV CHEF_LICENSE "accept"
COPY . /inspec/
RUN inspec archive --output /inspec/inspec-profile.tar.gz /inspec

# Base runtime image for GCP
FROM chef/inspec:4.29.3
RUN apt-get update && apt-get clean
COPY assets/* /inspec/
COPY --from=build /inspec/inspec-profile.tar.gz /inspec/
ENV GOOGLE_APPLICATION_CREDENTIALS /inspec/gcp-creds.json
ENV CHEF_LICENSE "accept"

RUN groupadd -g 999 appuser && useradd -d /inspec/ -g appuser appuser
RUN chown -R appuser /inspec/
USER appuser

ENTRYPOINT [ "sh" ]
CMD [ "/inspec/inspec-wrapper.sh" ]
