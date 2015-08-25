var Parent = React.createClass({
	displayName: "Parent",
	getInitialState: function() {
		return {value: "Guest"};
	},
	onChange: function() {
		this.setState({value: React.findDOMNode(this.refs.input).value});
	},
	reset: function() {
		this.setState(this.getInitialState());
	},
	render: function() {
		return (
			<div>
				<input ref="input" value={this.state.value} onChange={this.onChange} />
				<Child value={this.state.value} reset={this.reset} />
			</div>
		);
	}
});

var Child = React.createClass({
	displayName: "Child",
	propTypes: {
		value: React.PropTypes.string.isRequired,
		reset: React.PropTypes.func.isRequired
	},
	render: function() {
		return (
			<div>
				<div>Hello {this.props.value}</div>
				<button onClick={this.props.reset}>Reset</button>
			</div>
		);
	}
});

React.render(<Parent />, document.body);
