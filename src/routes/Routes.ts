const baseUrl = (): string => "/api/v1/";

const url = (path: string): string => baseUrl() + path;

export { baseUrl, url };
