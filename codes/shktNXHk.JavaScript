import _ from 'lodash';
import React, {Component} from 'react';
import { ScrollView, FlatList } from 'react-native';
import { s, h, c, t } from '../../../rootHelper/rootHelper';

import PropTypes from 'prop-types';

const SCROLL_THRESHOLD = 0.2;

class VerticalViewPager extends Component {

    constructor(props) {
        super(props);

        this._scrolling = false;
        this._enableScrollTimer = null;
        this._layout = null;
        this._contentOffset = null;
        this._scrollDirection = null;
        this.state = {
            scrollEnabled: true
        };
    }

    scrollTo() {
        const MARGIN = 4;
        let i = this._contentOffset.y / (c.PLACE_HEIGHT + MARGIN);

        if (this._scrollDirection === 'down') {
            i = Math.ceil(i)
        } else {
            i = Math.floor(i);
        }

        if (i < 0) {
            i = 0;
        }

        if (i < this.props.data.length) {
            this.scrollview.scrollToIndex({index: i, animated: true});
        }
    }

    onScrollBeginDrag(e) {
        // record starting points
        this._setStartOffset(e.nativeEvent.contentOffset);
        this._scrolling = true;
        _.invoke(this.props, 'onScrollBeginDrag', e);
    }

    onScrollEndDrag(e) {
        // record ending points
        this._setEndOffset(e.nativeEvent.contentOffset);
        this._scrolling = false;
        // calculate the offset the user scrolls
        this._calculateOffsets();
        _.invoke(this.props, 'onScrollEndDrag', e);
    }

    nextPage() {
        // calculate next y offset value
        const {height} = this._layout;
        const {y: startY} = this._startContentOffset;
        const nextYOffset = startY + height;
        // scrollTo that point
        this.scrollTo({y: nextYOffset, animated: true});
        this.setState({
            scrollEnabled: true
        });
    }

    prevPage() {
        // calcullate prev page's y offset value
        const {height} = this._layout;
        const {y: startY} = this._startContentOffset;
        const nextYOffset = startY - height;
        // scrollTo that point
        this.scrollTo({y: nextYOffset, animated: true});
        this.setState({
            scrollEnabled: true
        });
    }

    onScroll(e) {
        if (this._contentOffset) {
            this._scrollDirection = e.nativeEvent.contentOffset.y > this._contentOffset.y ? 'down' : 'top';
        } else {
            this._scrollDirection = 'down';
        }

        this._contentOffset = e.nativeEvent.contentOffset;
    }

    _setStartOffset(startOffset) {
        this._startContentOffset = startOffset;
        this._endContentOffset = null;
    }

    _setEndOffset(endOffset) {
        this._endContentOffset = endOffset;
    }

    _calculateOffsets() {
        const {height} = this._layout;
        const {y: startY} = this._startContentOffset;
        const {y: endY} = this._endContentOffset;
        if ((endY - startY) > height * SCROLL_THRESHOLD) {
            this.nextPage();
        } else if ((endY - startY) < -height * SCROLL_THRESHOLD) {
            this.prevPage();
        } else {
            this.scrollTo({y: startY});
        }
    }

    _refScrollView(scrollview) {
        this.scrollview = scrollview;
    }

    _onLayout(e) {
        this._layout = e.nativeEvent.layout;
    }

    onMomentumScrollEnd(e) {
        // Because onMomentumScrollEnd event is already be replace by onScroll event
        // that will event onMomentumScrollEnd if necassary.
        // Here define this event callback only avoid user to listen onMomentumScrollEnd
        // of native ScrollView that may cause troubles.
    }


    componentWillReceiveProps(nextProps) {
        const {contentOffset} = this.props;
        const {contentOffset: nextContentOffset} = nextProps;
        if (contentOffset !== nextContentOffset) {
            // contentOffset is iOS only attribute in ScrollView. Use scrollTo to mimic this bahavior in Android.
            // XXX If update swiper children and also change contentOffset, scrollTo will not work. Don't know why...
            setTimeout(function() {
                this.scrollTo({...nextContentOffset, animated: true});
            }.bind(this), 25)
        }
    }

    getItemLayout = (data, index) => {
        const offset = c.PLACE_HEIGHT * index + 4 * index - 6;

        return { length: c.PLACE_HEIGHT, offset, index };
    };

    render() {
        const {
            contentContainerStyle,
            style
        } = this.props;
        return (
            <FlatList
                {...this.props}
                ref={scrollview => this._refScrollView(scrollview)}
                onLayout={e => this._onLayout(e)}
                horizontal={false}
                style={style}
                scrollEnabled={this.state.scrollEnabled}
                onScrollBeginDrag={e => this.onScrollBeginDrag(e)}
                onScrollEndDrag={e => this.onScrollEndDrag(e)}
                onMomentumScrollEnd={e => this.onMomentumScrollEnd(e)}
                getItemLayout={this.getItemLayout}
                onScroll={e => this.onScroll(e)}
                scrollEventThrottle={50}
                contentContainerStyle={contentContainerStyle}
                renderItem={this.props.renderItem}
                keyExtractor={({place_id}) => place_id}
                data={this.props.data}
            />
        )
    }
}

VerticalViewPager.propTypes = {
    // style of page container
    contentContainerStyle: PropTypes.oneOfType([
        PropTypes.object,
        PropTypes.number
    ]),
    contentOffset: PropTypes.object,
    // onScrollBeginDrag(nativeEvent)
    // a.k.a onScrollBegin
    onScrollBeginDrag: PropTypes.func,
    // onMomentumScrollEnd(nativeEvent)
    // nativeEvent.nativeEvent.contentOffset or nativeEvent.nativeEvent.position must exists
    // a.k.a onScrollEnd
    onMomentumScrollEnd: PropTypes.func,
    // onScrollEndDrag(nativeEvent)
    // nativeEvent.nativeEvent.contentOffset must exists
    // a.k.a. onScrollEndDrag
    onScrollEndDrag: PropTypes.func,
    style: PropTypes.oneOfType([
        PropTypes.object,
        PropTypes.number
    ])
};

export default VerticalViewPager;