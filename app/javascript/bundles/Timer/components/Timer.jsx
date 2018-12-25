// import PropTypes from 'prop-types';
import React from 'react';
import Stopwatch from './Stopwatch'

export default class Timer extends React.Component {
  static propTypes = {
    // name: PropTypes.integer.isRequired, // this is passed from the Rails view
  };


  constructor(props) {
    super(props);

    this.state = {
      startTime: this.props.start_time,
    };
  }


  render() {
    return (
      <div className="Timer">
        <Stopwatch
          startTime={this.state.startTime}
        />
      </div>
    );
  }
}
