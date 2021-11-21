import { requireNativeComponent } from 'react-native';
import PropTypes from 'prop-types';
import React from 'react';

class ChartView extends React.Component {
    render() {
        return <RNTChart {...this.props} />
    }
}

ChartView.propTypes = {
    values: PropTypes.arrayOf(PropTypes.shape ({
        x: PropTypes.number.isRequired,
        y: PropTypes.number.isRequired
    }))
};

// requireNativeComponent automatically resolves 'RNTChart' to 'RNTChartManager'
var RNTChart = requireNativeComponent('RNTChart');
module.exports = ChartView