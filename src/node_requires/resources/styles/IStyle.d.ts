declare interface IStyle extends IAsset {
    name: string;
    font: {
        family: string;
        size: number;
        italic: boolean;
        weight: 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900;
        halign: 'left' | 'center' | 'right'
        lineHeight?: number;
        wrap: boolean;
        wrapPosition: number;
    };
    fill?: {
        type: 0 | 1;
        color: string;
        color1: string;
        color2: string;
        gradtype: 1 | 2;
    };
    stroke?: {
        weight: number;
        color: string;
    };
    shadow?: {
        blur: number;
        color: string;
        x: number;
        y: number;
    };
}
