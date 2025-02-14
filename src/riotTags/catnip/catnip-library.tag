mixin propsVars
    h3
        | {voc.properties}
        hover-hint(text="{voc.propertiesHint}")
    catnip-block(
        each="{prop in opts.props}"
        if="{!opts.scriptmode}"
        block="{({lib: 'core.hidden', code: 'property', values: {variableName: prop}})}"
        dragoutonly="dragoutonly"
        readonly="readonly"
        ondragstart="{parent.onVarDragStart}"
        draggable="draggable"
        ondragend="{parent.resetTarget}"
        oncontextmenu="{parent.onContextMenu}"
    )
    catnip-block(
        each="{bhprop in opts.behaviorprops}"
        if="{!opts.scriptmode}"
        block="{({lib: 'core.hidden', code: 'behavior property', values: {variableName: bhprop}})}"
        dragoutonly="dragoutonly"
        readonly="readonly"
        ondragstart="{parent.onVarDragStart}"
        draggable="draggable"
        ondragend="{parent.resetTarget}"
    )
    catnip-block(
        if="{opts.scriptmode}"
        block="{({lib: 'core.hidden', code: 'script options', values: {}})}"
        dragoutonly="dragoutonly"
        readonly="readonly"
        ondragstart="{parent.onVarDragStart}"
        draggable="draggable"
        ondragend="{parent.resetTarget}"
    )
    br(if="{opts.scriptmode || opts.props.length || opts.behaviorprops.length}")
    button.inline(onclick="{promptNewProperty}" if="{!opts.scriptmode}")
        svg.feather
            use(href="#plus")
        span {voc.createNewProperty}
    h3
        | {voc.variables}
        hover-hint(text="{voc.variablesHint}")
    catnip-block(
        each="{variable in opts.variables}"
        block="{({lib: 'core.hidden', code: 'variable', values: {variableName: variable}})}"
        dragoutonly="dragoutonly"
        readonly="readonly"
        ondragstart="{parent.onVarDragStart}"
        draggable="draggable"
        ondragend="{parent.resetTarget}"
        oncontextmenu="{parent.onContextMenu}"
    )
    br(if="{opts.variables.length}")
    catnip-block(
        each="{eventvar in opts.eventvars}"
        block="{({lib: 'core.hidden', code: 'event variable', values: {variableName: eventvar}})}"
        dragoutonly="dragoutonly"
        readonly="readonly"
        ondragstart="{parent.onVarDragStart}"
        draggable="draggable"
        ondragend="{parent.resetTarget}"
    )
    br(if="{opts.eventvars.length}")
    button.inline(onclick="{promptNewVariable}")
        svg.feather
            use(href="#plus")
        span {voc.createNewVariable}

//-
    @attribute variables (string[])
    @attribute props (string[])
    @attribute behaviorprops (string[])
    @attribute eventvars (string[])
    @attribute [scriptmode] (atomic)
        Disables some features of the editor that make sense for script asset type.
catnip-library(class="{opts.class}").flexrow
    .flexfix
        .aSearchWrap.flexfix-header
            input.wide(type="text" oninput="{search}" ref="search" onclick="{selectSearch}" value="{searchVal}")
            svg.feather
                use(href="#search")
        // Scrollable layout
        .flexfix-body(show="{!searchVal.trim()}" ref="mainpanel" if="{localStorage.scrollableCatnipLibrary === 'on'}")
            +propsVars()
            .aSpacer
            .center(if="{!showLibrary}")
                svg.feather.rotate
                    use(href="#more-horizontal")
            virtual(each="{cat in categories}" if="{showLibrary}")
                h3(ref="categories" if="{!cat.hidden}")
                    svg.feather
                        use(href="#{cat.icon || 'grid-random'}")
                    span {voc.coreLibs[cat.i18nKey] || cat.name}
                catnip-block(
                    each="{block in cat.items}"
                    block="{({lib: block.lib, code: block.code, values: {}})}"
                    dragoutonly="dragoutonly"
                    readonly="readonly"
                    ondragstart="{parent.parent.onDragStart}"
                    draggable="draggable"
                    ondragend="{parent.resetTarget}"
                )
        // Paged layout (default)
        .flexfix-body(show="{!searchVal.trim()}" ref="mainpanel" if="{localStorage.scrollableCatnipLibrary !== 'on' && tab === 'propsVars'}")
            +propsVars()
            br
            catnip-block(
                each="{block in categories[0].items}"
                block="{({lib: block.lib, code: block.code, values: {}})}"
                dragoutonly="dragoutonly"
                readonly="readonly"
                ondragstart="{parent.onDragStart}"
                draggable="draggable"
                ondragend="{parent.resetTarget}"
            )
        .flexfix-body(show="{!searchVal.trim()}" ref="mainpanel" if="{localStorage.scrollableCatnipLibrary !== 'on' && tab !== 'propsVars'}")
            h3(ref="categories" if="{!tab.hidden}")
                svg.feather
                    use(href="#{tab.icon || 'grid-random'}")
                span {voc.coreLibs[tab.i18nKey] || tab.name}
            catnip-block(
                each="{block in tab.items}"
                block="{({lib: block.lib, code: block.code, values: {}})}"
                dragoutonly="dragoutonly"
                readonly="readonly"
                ondragstart="{parent.onDragStart}"
                draggable="draggable"
                ondragend="{parent.resetTarget}"
            )
        .flexfix-body(if="{searchVal.trim() && searchResults.length}")
            catnip-block(
                each="{block in searchResults}"
                block="{({lib: block.lib, code: block.code, values: {}})}"
                dragoutonly="dragoutonly"
                readonly="readonly"
                ondragstart="{parent.onDragStart}"
                draggable="draggable"
                ondragend="{resetTarget}"
            )
        .flexfix-body.center(if="{searchVal.trim() && !searchResults.length}")
            svg.anIllustration
                use(xlink:href="data/img/weirdFoldersIllustration.svg#illustration")
            br
            span {vocGlob.nothingToShowFiller}
    .catnip-library-CategoriesShortcuts.aButtonGroup.vertical
        .catnip-library-aShortcut.button(
            title="{voc.properties}"
            onclick="{localStorage.scrollableCatnipLibrary === 'on' ? scrollToTop : selectTab('propsVars')}"
            class="{active: tab === 'propsVars'}"
        )
            svg.feather.a
                use(href="#archive")
            div  {voc.properties}
        .catnip-library-aShortcut.button(
            each="{cat, ind in categories}" if="{!cat.hidden}"
            title="{cat.name}"
            onclick="{localStorage.scrollableCatnipLibrary === 'on' ? scrollToCat : selectTab(cat)}"
            class="{active: tab === cat}"
        )
            svg.feather.a
                use(href="#{cat.icon || 'grid-random'}")
            div {voc.coreLibs[cat.i18nKey] || cat.name}
    context-menu(if="{contextVarName}" menu="{contextMenu}" ref="menu")
    script.
        this.namespace = 'catnip';
        this.mixin(require('src/node_requires/riotMixins/voc').default);

        // Delay the display of the library so the editor loads in quicker
        this.showLibrary = false;
        this.on('mount', () => {
            setTimeout(() => {
                this.showLibrary = true;
                this.update();
            });
        });

        const {blocksLibrary, startBlocksTransmit, getDeclaration, setSuggestedTarget, searchBlocks, blockFromDeclaration, emptyTexture} = require('src/node_requires/catnip');
        this.categories = blocksLibrary;

        this.onDragStart = e => {
            const {block} = e.item;
            const declaration = getDeclaration(block.lib, block.code);
            e.dataTransfer.dropEffect = 'move';
            e.dataTransfer.setData(`ctjsblocks/${declaration.type}`, 'hello uwu');
            e.dataTransfer.setDragImage(emptyTexture, 0, 0);
            startBlocksTransmit([blockFromDeclaration(declaration)], this.opts.blocks, false, true);
            const bounds = e.target.getBoundingClientRect();
            window.signals.trigger(
                'blockTransmissionStart',
                e,
                e.target.outerHTML,
                bounds.left - e.clientX,
                bounds.top - e.clientY
            );
        };
        this.onVarDragStart = e => {
            e.dataTransfer.dropEffect = 'move';
            e.dataTransfer.setData('ctjsblocks/computed', 'hello uwu');
            e.dataTransfer.setDragImage(emptyTexture, 0, 0);
            const bounds = e.target.getBoundingClientRect();
            let code, value;
            if (e.item.prop) {
                code = 'property';
                value = e.item.prop;
            } else if (e.item.bhprop) {
                code = 'behavior property';
                value = e.item.bhprop;
            } else if (e.item.variable) {
                code = 'variable';
                value = e.item.variable;
            } else if (e.item.eventvar) {
                code = 'event variable';
                value = e.item.eventvar;
            }
            startBlocksTransmit([{
                lib: 'core.hidden',
                code,
                values: {
                    variableName: value
                }
            }], this.opts.blocks, false, true);
            window.signals.trigger(
                'blockTransmissionStart',
                e,
                e.target.outerHTML,
                bounds.left - e.clientX,
                bounds.top - e.clientY
            );
        };
        this.resetTarget = () => {
            setSuggestedTarget();
        };

        this.tab = 'propsVars';
        this.selectTab = tab => () => {
            this.tab = tab;
            if (this.searchVal.trim()) {
                this.searchVal = '';
            }
        };

        const ease = x => 1 - ((1 - x) ** 5);
        this.scrollToCat = e => {
            if (this.searchVal.trim()) {
                this.searchVal = '';
                this.update();
            }
            const {ind} = e.item;
            let a = 0;
            const timePrev = Number(new Date()),
                  startScroll = this.refs.mainpanel.scrollTop,
                  targetScroll = this.refs.categories[ind].offsetTop;
            const scrollToCategory = () => {
                a += (Number(new Date()) - timePrev) / 1000;
                if (a > 1) {
                    a = 1;
                } else {
                    window.requestAnimationFrame(scrollToCategory);
                }
                const b = ease(a);
                this.refs.mainpanel.scrollTo(0, startScroll * (1 - b) + targetScroll * b);
            };
            scrollToCategory();
        };
        this.scrollToTop = () => {
            if (this.searchVal.trim()) {
                this.searchVal = '';
                this.update();
            }
            let a = 0;
            const timePrev = Number(new Date()),
                  startScroll = this.refs.mainpanel.scrollTop,
                  targetScroll = 0;
            const scrollToCategory = () => {
                a += (Number(new Date()) - timePrev) / 1000;
                if (a > 1) {
                    a = 1;
                } else {
                    window.requestAnimationFrame(scrollToCategory);
                }
                const b = ease(a);
                this.refs.mainpanel.scrollTo(0, startScroll * (1 - b) + targetScroll * b);
            };
            scrollToCategory();
        };

        this.searchVal = '';
        this.search = e => {
            this.searchVal = e.target.value;
            if (this.searchVal.trim()) {
                this.searchResults = searchBlocks(this.searchVal.trim());
            }
        };
        this.selectSearch = () => {
            this.refs.search.select();
        };

        this.promptNewProperty = () => {
            window.alertify.prompt(this.voc.newPropertyPrompt)
            .then(e => {
                const val = e.inputValue;
                if (!val || !val.trim()) {
                    return;
                }
                this.opts.props.push(val.trim());
                this.update();
            });
        };
        this.promptNewVariable = () => {
            window.alertify.prompt(this.voc.newVariablePrompt)
            .then(e => {
                const val = e.inputValue;
                if (!val || !val.trim()) {
                    return;
                }
                this.opts.variables.push(val.trim());
                this.update();
            });
        };
        this.contextVarName = false;
        this.onContextMenu = e => {
            e.preventDefault();
            e.stopPropagation();
            this.contextVarName = e.item.prop || e.item.variable;
            this.contextType = e.item.prop ? 'prop' : 'variable';
            this.update();
            this.refs.menu.popup(e.clientX, e.clientY);
        };
        this.contextMenu = {
            opened: true,
            items: [{
                label: this.vocGlob.delete,
                icon: 'trash',
                click: () => {
                    if (this.contextType === 'prop') {
                        this.opts.props.splice(this.opts.props.indexOf(this.contextVarName), 1);
                    } else {
                        this.opts.variables.splice(this.opts.variables.indexOf(this.contextVarName), 1);
                    }
                    this.contextVarName = false;
                    this.update();
                }
            }]
        };
