---
type: "blog"
title: "How I Built My Custom Hugo Pagination"
description: "I've been planning on improving the pagination control for my blog for some time, but it always seemed a bigger job than I really wanted to work on in my spare time, but I was wrong."
date: 2020-09-08T21:46:16+01:00
author: "Jon"
tags: ["blog", "programming", "gohugo.io"]
---
I've been planning on improving the pagination control for my blog for some time, but it always seemed a bigger job than I really wanted to work on in my spare time, but I was wrong. The only complexity was around the weird templating syntax that I hadn't _really_ got to grips with fully yet.

So I did some research first, why re-invent the wheel right? And I came across a [really good tutorial from Glenn McComb](https://glennmccomb.com/articles/how-to-build-custom-hugo-pagination/) where he went through how he built his, and seeing his examples, along with his explanations, made the syntax sink in better. I'd recommend giving his page a read first, as mine is based upon his with a few changes.

So if you've read Glenn's page, you'll see that his pager ended up like this for the 1st page:

```
1 2 3 4 5 > >>
```

resulting in this for page 4:

```
<< < 2 3 4 5 6 > >>
```

So as you can see, he's including 2 page links either side of the current page, and the first, previous, next and last pages too. I wanted to have something slightly different, so I mocked up a few ideas and tested them on an old iPhone SE (same size as the iPhone 5) as this is probably the narrowest screen still in use.

Anyway, I ended up happy with the following idea on the 1st page:

```
1 2 3 ... 7 >
```

resulting in this for page 4:

```
< 1 ... 3 4 5 ... 7 >
```

This way, visitors can see that the last page is number 7 (so they know how many pages there are), and that they can easily get back to the first page which is page 1.

So I started off with Glenn's example and removed the first and last buttons before starting off working out how to add the buttons for page 1 and the last numbered page.

Because we already track the maximum number of links on show at any time (`$max_links`), I based my logic for the page 1 button around that and the current page number, so I only show it if the current page number is greater or equal to the max links value (I opted for 3).

I also wrap this in a check to ensure that the total number of pages is greater than the maximum links to show. This stops page numbers from being shown twice.

```go
<!-- First page (if current page is greater than allowed limit) -->
{{ if gt $pag.TotalPages $max_links }}
  {{ if ge $pag.PageNumber $max_links }}
    <a href="{{ $pag.First.URL }}" aria-label="First" class="page-tag">1</a>
    <span>...</span>
  {{ end }}
{{ end }}
```

To follow on from Glenn's precedent of showing an example in a more familiar language, I'll also show the logic in JS:

```js
if ($pag.PageNumber >= $max_links) {
  // Show the markup
}
```

And then I turned my attention to the last numbered page button. So I still knew the maximum number of links to be shown, and I knew the total number of pages too from the paginator object, so I base that on whether the current page number is less or equal to the sum of total pages, less the max links plus 1. I also wrap this in the check to ensure that the total number of pages is greater than the maximum links to show.

```go
<!-- Show the last page index -->
{{ if gt $pag.TotalPages $max_links }}
  {{ if le $pag.PageNumber (sub $pag.TotalPages (sub $max_links 1)) }}
    <span>...</span>
    <a href="{{ $pag.Last.URL }}" aria-label="Last" class="page-tag">{{ $pag.TotalPages }}</a>
  {{ end }}
{{ end }}
```

To follow on from Glenn's precedent of showing an example in a more familiar language, I'll also show the logic in JS:

```js
if ($pag.PageNumber <= $pag.TotalPages - ($max_links + 1)) {
  // Show the markup
}
```

I'm pretty pleased with the end result. I'd maybe like an additional number either side of the current page too but I really wanted to retain compatibility with the smaller mobile device screens.

This is my end result ([relevant commit @ GitHub](https://github.com/jonifen/jonifen-web/blob/499c65f6b8a84fd975e6d20ceec8985e55e5b3cf/layouts/partials/widgets/pager.html)):

```go
{{ if gt $.Paginator.TotalPages 1 }}
<div class="pagination">
  {{ $pag := .Paginator }}

  {{ $adjacent_links := 1 }}
  {{ $max_links := (add (mul $adjacent_links 2) 1) }}
  {{ $lower_limit := (add $adjacent_links 1) }}
  {{ $upper_limit := (sub $pag.TotalPages $adjacent_links) }}

  {{ if $pag.HasPrev }}
  <a href="{{ $pag.Prev.URL }}" aria-label="Previous" class="page-tag">&lt;</a>
  {{ end }}

  <!-- First page (if current page is greater than allowed limit) -->
  {{ if gt $pag.TotalPages $max_links }}
    {{ if ge $pag.PageNumber $max_links }}
    <a href="{{ $pag.First.URL }}" aria-label="First" class="page-tag">1</a>
    <span>...</span>
    {{ end }}
  {{ end }}

  <!-- Iterate the pager to show pages within ruleset -->
  {{ range $pag.Pagers }}
    {{ $.Scratch.Set "page_number_flag" false }}

    <!-- Identify if the current page is within the ruleset to be shown (or not) -->
    {{ if gt $pag.TotalPages $max_links }}
      {{ if le $pag.PageNumber $lower_limit }}
        {{ if le .PageNumber $max_links }}
          {{ $.Scratch.Set "page_number_flag" true }}
        {{ end }}
      {{ else if ge $pag.PageNumber $upper_limit }}
        {{ if gt .PageNumber (sub $pag.TotalPages $max_links) }}
          {{ $.Scratch.Set "page_number_flag" true }}
        {{ end }}
      {{ else }}
        {{ if and ( ge .PageNumber (sub $pag.PageNumber $adjacent_links) ) ( le .PageNumber (add $pag.PageNumber $adjacent_links) ) }}
          {{ $.Scratch.Set "page_number_flag" true }}
        {{ end }}
      {{ end }}
    {{ else }}
      {{ $.Scratch.Set "page_number_flag" true }}
    {{ end }}

    {{ if eq ($.Scratch.Get "page_number_flag") true }}
    <a href="{{ .URL }}" aria-label="{{ .PageNumber }}" class="page-tag{{ if eq . $pag }} current{{ end }}">{{ .PageNumber }}</a>
    {{ end }}
  {{ end }}

  <!-- Show the last page index -->
  {{ if gt $pag.TotalPages $max_links }}
    {{ if le $pag.PageNumber (sub $pag.TotalPages (sub $max_links 1)) }}
    <span>...</span>
    <a href="{{ $pag.Last.URL }}" aria-label="Last" class="page-tag">{{ $pag.TotalPages }}</a>
    {{ end }}
  {{ end }}

  {{ if $pag.HasNext }}
  <a href="{{ $pag.Next.URL }}" aria-label="Next" class="page-tag">&gt;</a>
  {{ end }}
</div>
{{ end }}
```

If you've any questions, or you just wanted to offer suggestions to improve things, give me a shout at one of the options at the bottom of the page.