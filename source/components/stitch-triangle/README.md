# Triangle Mixin for Sass

Triangles are pretty rad.

```scss
.dropdown {
  &:before {
    @include triangle($direction: 'bottom', $width: 100px, $height: 50px, $color: black);
  }
}
```