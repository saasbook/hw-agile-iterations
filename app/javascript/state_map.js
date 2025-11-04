import * as d3 from 'd3';
import * as stateMapUtils from './state_map_utils';

$(() => {
  const stateMap = stateMapUtils.StateMap();
  d3.json(stateMap.topojsonUrl).then((topology) => {
    const mapAssets = stateMapUtils.parseTopojson(stateMap, topology);
    stateMap.svgElement.selectAll('path')
      .data(mapAssets.geojson.features)
      .enter()
      .append('path')
      .attr('class', 'actionmap-view-region')
      .attr('tabindex', 0)
      .attr('role', 'link')
      .attr('aria-label', (d) => stateMap.counties[d.properties.COUNTYFP].name)
      .attr('data-county-name', (d) => stateMap.counties[d.properties.COUNTYFP].name)
      .attr('data-county-fips-code', (d) => d.properties.COUNTYFP)
      .attr('d', mapAssets.path);

    stateMapUtils.setupEventHandlers(stateMap);
  });
});
