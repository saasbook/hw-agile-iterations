import * as d3 from 'd3';
import * as topojson from 'topojson';
import mapUtils from './map_utils';

export const StateMap = () => {
  const map = Object.create(Map.prototype);
  map.infoContainer = $('#actionmap-info-container');
  map.state = JSON.parse(
    map.infoContainer.attr('data-state'),
  );
  map.counties = JSON.parse(
    map.infoContainer.attr('data-counties'),
  );
  map.state.std_fips_code = mapUtils.zeroPad(map.state.fips_code, 2);
  map.objectKeys = `cb_2019_${map.state.std_fips_code}_cousub_500k`;
  map.topojsonUrl = `${window.location.origin}${map.infoContainer.attr('data-state-topojson-file')}`;
  map.width = 960;
  map.height = 650;

  map.svgElement = d3.select('#actionmap-state-counties-view')
    .attr('width', map.width)
    .attr('height', map.height)
    .attr('preserveAspectRatio', 'xMinYMin meet');
  return map;
};

const getProjection = (stateMap, geojson) => {
  if (stateMap.state.symbol === 'AK') {
    return d3.geoConicEqualArea().scale(1400)
      .rotate([154, 0])
      .center([0, 62])
      .parallels([55, 65])
      .clipExtent([[-1, -1], [stateMap.width + 1, stateMap.height + 1]]);
  }
  return d3.geoMercator()
    .fitExtent(
      [
        [20, 20],
        [stateMap.width, stateMap.height],
      ],
      geojson,
    );
};

export const parseTopojson = (stateMap, topology) => {
  const geojson = topojson.feature(
    topology,
    topology.objects[stateMap.objectKeys],
  );
  const projection = getProjection(stateMap, geojson);
  const path = d3.geoPath()
    .projection(projection);
  return {
    geojson,
    path,
  };
};

export const setupEventHandlers = (stateMap) => {
  const targets = $('.actionmap-view-region');
  const hoverHtmlProvider = (elem) => {
    const county = elem.attr('data-county-name');
    return `${county}, ${stateMap.state.symbol}`;
  };
  const clickCallback = (elem) => {
    const county = elem.attr('data-county-name');
    const query = encodeURIComponent(`${county}, ${stateMap.state.symbol}`);
    window.location.href = `/search/${query}`;
  };
  mapUtils.handleMapMouseEvents(targets, hoverHtmlProvider, clickCallback);
};
