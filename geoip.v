module geoip

import net.http
import json

struct JSON {
	accuracy u64
	area_code string
	asn u64
	continent_code string
	country string
	country_code string
	country_code3 string [skip]
	ip string
	latitude string 
	longitude string
	organization string
	organization_name string
}

pub fn geoip(ip string) ?JSON {
	if ip == "" {
		resp := http.get("https://get.geojs.io/v1/ip/geo.json") or {
			return error(err)
		}
		geo := json.decode(JSON, resp.text) or {
			return error('Failed to decode json')
		}
		return geo
	}
	resp := http.get("https://get.geojs.io/v1/ip/geo/"+ ip +".json") or { 
		return error(err) 
	}
	geo := json.decode(JSON, resp.text) or {
		return error('Failed to decode json')
	}
	return geo
}

struct COUNTRY {
	country string 
	country_3 string [skip]
	ip string
	name string
}

pub fn country(ip string) ?COUNTRY {
	if ip == "" {
		resp := http.get("https://get.geojs.io/v1/ip/country.json") or {
			return error(err)
		}
		ipjson := json.decode(COUNTRY, resp.text) or {
			return error('Failed to decode json')
		}
		return ipjson
	}
	resp := http.get("https://get.geojs.io/v1/ip/country/"+ ip +".json") or { 
		return error(err) 
	}
	ipjson := json.decode(COUNTRY, resp.text) or {
		return error('Failed to decode json')
	}
	return ipjson
}

struct IPJSON {
	ip string
}

pub fn ip() ?IPJSON {
	resp := http.get("https://get.geojs.io/v1/ip.json") or {
		return error(err)
	}
	ip := json.decode(IPJSON, resp.text) or {
		return error('Failed to decode json')
	}
	return ip
}
struct PTRJSON {
	ptr string
}

pub fn ptr(ip string) ?PTRJSON {
	if ip == "" {
		resp := http.get("https://get.geojs.io/v1/dns/ptr.json") or {
			return error(err)
		}
		ptrjson := json.decode(PTRJSON, resp.text) or {
			return error('Failed to decode json')
		}
		return ptrjson
	}
	resp := http.get("https://get.geojs.io/v1/dns/ptr/"+ ip +".json") or { 
		return error(err) 
	}
	ptrjson := json.decode(PTRJSON, resp.text) or {
		return error('Failed to decode json')
	}
	return ptrjson
}
