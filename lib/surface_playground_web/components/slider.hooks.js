let Slider = {
    mounted() {
        this.el.addEventListener("input", (e) => {
            this.pushEvent("update-range", { value: e.target.value });
        });
    }
}

export { Slider };